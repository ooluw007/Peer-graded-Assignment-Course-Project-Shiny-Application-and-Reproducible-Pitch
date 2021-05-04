library(shiny)


shinyServer(function(input, output) {
    
    
    
    output$plot <- renderPlot({
        
        nsim <- 1000 # Number of simulations
        n <- 500 # number of samples
        popMean <- 50 # Population mean 
        lambda <- 1/popMean # Parameter rate
        popVar <- 25 # Population variance
        popStDev <- 5 # Population standard deviation
        
        
        samp2 <- rexp(n = input$n*input$nsim, rate = lambda) # Exponential sampling of n=40 with 
        #samp2_df <- tibble(samp2) # put samp2 data in a dataframe.
        
        samp2_mat <- matrix(samp2, input$nsim)
        samp2Mean <- apply(samp2_mat, 1, mean)
        samp2Mean_df <- tibble(samp2Mean)
        
        meanOfMeans <- sum(samp2Mean)/input$nsim
        varOfMeans <- sum((samp2Mean - meanOfMeans)^2)/(input$nsim-1)
        stdDevOfMeans <- sqrt(varOfMeans)
        neg2std <- meanOfMeans - 2*stdDevOfMeans
        pos2std <- meanOfMeans + 2*stdDevOfMeans
        
        
        ggplot(data = samp2Mean_df) +
            aes(x = samp2Mean) +
            geom_density(size = 2, alpha = .5, fill = "coral") +
            geom_vline(
                size = 2, 
                alpha = .9, 
                xintercept = c(popMean, meanOfMeans, neg2std, pos2std),
                color = c("red", "navyblue", "darkmagenta", "deepskyblue")) +
            annotate("text",
                     x = popMean,
                     y = .2,
                     label = (paste0("Pop Mean (", round(popMean,2), ")")),
                     size = 5, fontface = "bold",
                     angle = 30,
                     color = "red") +
            annotate("text",
                     x = meanOfMeans,
                     y = .25,
                     label = (paste0("Sample Means (", round(meanOfMeans,2), ")")),
                     size = 5, fontface = "bold",
                     angle = 30,
                     color = "navyblue"
            ) +
            annotate("text",
                     x = neg2std,
                     y = 0.00,
                     label = (paste0("-2SD (", round(neg2std,2), ")")),
                     color = "darkmagenta",
                     size = 5, fontface = "bold") +
            annotate("text",
                     x = pos2std,
                     y = 0.00,
                     label = (paste0("+2SD (", round(pos2std,2), ")")),
                     color = "deepskyblue",
                     size = 5, fontface = "bold") +
            annotate("text",
                     x = 50,
                     y = 0.35,
                     label = "Red: Population Mean",
                     color = "Red",
                     size = 5, fontface = "bold") +
            annotate("text",
                     x = 50,
                     y = 0.33,
                     label = "Navy Blue: Sample Mean",
                     color = "navyblue",
                     size = 5, fontface = "bold") +
            labs(
                x = "X",
                y = "Density",
                caption = "As the sample size increases, sample mean  
                           approximates population mean"
            )
        
        
        
    })
    
    
    
})
