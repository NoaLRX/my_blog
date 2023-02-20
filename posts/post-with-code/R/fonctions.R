divide_triangle <- function(x1, y1, x2, y2, x3, y3) {
  # Calcul des coordonnées des points A, B et C
  A <- c(x1, y1)
  B <- c(x2, y2)
  C <- c(x3, y3)
  
  # Calcul des coordonnées des points D, E et F (milieux des côtés)
  D <- (A + B) / 2
  E <- (B + C) / 2
  F <- (C + A) / 2
  
  # Calcul des coordonnées des points des 3 triangles résultants
  T1 <- rbind(A, D, F)
  T2 <- rbind(D, B, E)
  T3 <- rbind(E, C, F)
  
  # Retourne les 3 triangles
  return(list(T1, T2, T3))
}


divide_list_triangle <- function(liste_triangle){ 
  sous_liste <- list()
  for (i in liste_triangle){ 
    sous_liste <- append(sous_liste, divide_triangle(i[1], i[2], i[3], i[4], i[5], i[6]))
  }
  return(sous_liste)
}


library(heron)

liste = divide_triangle(0,0,0,1,0.5,sqrt(3)/2) 
library(graphics)

library(ggplot2)

plot_triangles <- function(list_triangle) {
  plot_data <- data.frame(x = numeric(), y = numeric(), group = numeric())
  for (i in 1:length(list_triangle)) {
    triangle <- list_triangle[[i]]
    plot_data <- rbind(plot_data,
                       data.frame(x = c(triangle[1,1], triangle[2,1], triangle[3,1]),
                                  y = c(triangle[1,2], triangle[2,2], triangle[3,2]),
                                  group = i))
  }
  
  ggplot(plot_data, aes(x, y, group = group)) +
    geom_polygon(color = "black")+
    scale_x_continuous(limits = c(-0.5, 1.1), expand = c(-0.3, 0.7)) +
    scale_y_continuous(limits = c(-0.1, 1.4), expand = c(-0.8, -0.4)) +
    theme_void()
}

plot_triangles(liste)



