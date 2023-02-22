#-------------------------------------------------------------------------------
# FONCTION DIVIDE_TRIANGLE----
#-------------------------------------------------------------------------------

#' @title divide_triangle
#' @description cette fonction prend en entrée une matrice avec les coordonées 
#' des points X et Y des côtés A,B,C d'un triangle et renvoie une liste avec 
#' les coordonées X et Y de chacun des côtés et sommets du triangle 
#' @param triangle une matrice des coordonnées X etY des trois côtés A,B,C d'un 
#' triangle
#'
#' @return une liste avec les coordonnées X et Y de chacun des côtés et sommets
#' du triangle 
#' @export
#'
#' @examples
#' divide_triangle(matrix(c(0, 0, 1, 0, 0.5, sqrt(3)/2), nrow = 3, ncol = 2))
#' divide_triangle(matrix(c(1, 2, 3, 1, 2, 3, nrow = 3, ncol = 2)))

divide_triangle <- function(triangle) {
  #On définit chaque sommet du triangle
  A <- triangle[1,]
  B <- triangle[2,]
  C <- triangle[3,]
  
  #On définit les millieux de chaque côtés du triangles
  AB <- (A + B) / 2
  AC <- (A + C) / 2
  BC <- (B + C) / 2
  
  #On peut désormais créer notre triangles
  triangle1 <- rbind(A, AB, AC)
  triangle2 <- rbind(B, AB, BC)
  triangle3 <- rbind(C, AC, BC)
  
  #Cela nous retourne une liste propre avec les coordonnées de nos 3 triangles
  return(list(triangle1, triangle2, triangle3))
}


#-------------------------------------------------------------------------------
# FONCTION DIVIDE_LIST_TRIANGLE----
#-------------------------------------------------------------------------------
#' @title divide_list_triangle
#' @description Cette fonction prend en entrée une liste de triangle et applique
#' la fonction divide_triangle sur chacun des triangles, pour renvoyer une nouvelle
#' liste de triangle 
#' @param list_triangles 
#' 
#' @return
#' @export
#'
#' @examples
#' divide_list_triangle(liste1)
#' divide_list_triangle(liste2)


divide_list_triangle <- function(list_triangles) {
  #initilisation d'une "nouvelle" liste vide
  new_list <- list()
  #Itération pour chaque triangles contenus dans la liste originale
  for (i in 1:length(list_triangles)) {
    #o n rempli la nouvelle liste pour tout i dans la liste via la fonction
    # divide_triangles
    new_list <- c(new_list, divide_triangle(list_triangles[[i]]))
  }
  return(new_list)
}




#-------------------------------------------------------------------------------
# FONCTION PLOT_TRIANGLES----
#-------------------------------------------------------------------------------


#' @title plot_triangles
#' @description cette fonction prend en entrée une liste de triangles, et les 
#' représentent graphiquement grâce au package ggplot2 
#' @param list_triangle une liste de triangles
#' @import ggplot2
#' @return un graphique représentant les triangles avec ggplot2
#' @export
#'
#' @examples
#' plot_triangles(liste_triangle)


plot_triangles <- function(list_triangle) {
  
  # Créer un dataframe vide pour stocker les données de tracé
  plot_data <- data.frame(x = numeric(), y = numeric(), group = numeric())
  
  # Pour chaque triangle dans la liste, ajouter les coordonnées à plot_data
  for (i in 1:length(list_triangle)) {
    triangle <- list_triangle[[i]]
    plot_data <- rbind(plot_data,
                       data.frame(x = c(triangle[1,1], triangle[2,1], triangle[3,1]),
                                  y = c(triangle[1,2], triangle[2,2], triangle[3,2]),
                                  group = i))
  }
  
  # Créer un graphique ggplot avec les données stockées dans plot_data
  ggplot(plot_data, aes(x, y, group = group)) +
    # Tracer des polygones pour chaque groupe (triangle)
    geom_polygon(color = "black") +
    # Utiliser un thème vide pour le graphique
    theme_void()
}


#-------------------------------------------------------------------------------
# FONCTION DISTANCE----
#-------------------------------------------------------------------------------
#' @title distance
#' @description cette fonction permet le calcul de la distance euclidienne entre
#' deux points dans un plan cartésien
#' @param point1 correspond aux coordonnées du point X
#' @param point2 correspond aux coordonnées du point Y
#' @return renvoie la distance euclidienne entre les deux points.
#' @export

# calcul de la différence de coordonnées entre les deux points en x et en y
distance <- function(point1, point2) {
  # calcul de la distance euclidienne à partir des différences de coordonnées
  sqrt((point1[1] - point2[1])^2 + (point1[2] - point2[2])^2)
}


#-------------------------------------------------------------------------------
# FONCTION AIRE_TRIANGLES----
#-------------------------------------------------------------------------------
#' @title aire_triangles
#' @description Cette fonction prend en entrée une liste de triangles, et calcul
#' la somme leur aires respectives.
#' @param liste_triangles une list de triangles
#'
#' @return la somme des aires de tout les triangles issue de la liste de triangles.
#' @import heron
#' @export
#'
#' @examples
#' aire_triangles(liste_triangles)

aire_triangles <- function(liste_triangles) {
  somme_aires <- 0 # initialisation de la variable qui va stocker la somme des aires
  for (i in 1:length(liste_triangles)) { # boucle qui va itérer sur tous les triangles de la liste
    if (i %% 3 == 1) { # si l'indice i est congru à 1 modulo 3, on est en train de traiter un triangle qui commence par A
      A <- liste_triangles[[i]][1, ] # on récupère les coordonnées de A
      AB <- liste_triangles[[i]][2, ] # on récupère les coordonnées de AB
      AC <- liste_triangles[[i]][3, ] # on récupère les coordonnées de AC
      BC <- liste_triangles[[i+1]][3, ] # on récupère les coordonnées de BC (qui se trouve dans le triangle suivant)
    } else if (i %% 3 == 2) { # si l'indice i est congru à 2 modulo 3, on est en train de traiter un triangle qui commence par B
      B <- liste_triangles[[i]][1, ] # on récupère les coordonnées de B
      AB <- liste_triangles[[i]][2, ] # on récupère les coordonnées de AB
      BC <- liste_triangles[[i]][3, ] # on récupère les coordonnées de BC
      AC <- liste_triangles[[i-1]][3, ] # on récupère les coordonnées de AC (qui se trouve dans le triangle précédent)
    } else if (i %% 3 == 0) { # si l'indice i est congru à 0 modulo 3, on est en train de traiter un triangle qui commence par C
      C <- liste_triangles[[i]][1, ] # on récupère les coordonnées de C
      AC <- liste_triangles[[i]][2, ] # on récupère les coordonnées de AC
      BC <- liste_triangles[[i]][3, ] # on récupère les coordonnées de BC
      AB <- liste_triangles[[i-2]][2, ] # on récupère les coordonnées de AB (qui se trouve dans le triangle deux positions en arrière)
      # on calcule l'aire du triangle en utilisant la formule de Héron créer précédemment
      somme_aires <- somme_aires + heron(distance(A, B), distance(B, C), distance(C, A))
    }
  }
  return(somme_aires) # on retourne la somme des aires des triangles
}

