divide_tiangle <-  function(A,B,C){
  AB <- (A + B) / 2
  AC <- (A+C) / 2
  BC <- (B+C) / 2
  
  return(list(
    c(A, AB, AC),
    c(B, AB, BC),
    c(C, AC, BC)
  ))
}


divide_list_triangle <- function(liste_triangle){
  nouvelle_liste <- list()
  for (triangle in liste_triangle){
    nouveau_triangle <- divide_tiangle(triangle[1,],triangle[2,],triangle[3,])
    nouvelle_liste <- c(nouvelle_liste, nouveau_triangle)
  }
  return(nouvelle_liste)
}


plot_triangles <- function(list_triangles) {
  #itérer sur chaque triangle dans la liste
  for (triangle in list_triangles) {
    #tracer le triangle
    polygon(c(triangle[1,1], triangle[2,1], triangle[3,1]),
            c(triangle[1,2], triangle[2,2], triangle[3,2]),
            col = "black")
  }
}


A <- c(0, 0)
B <- c(0, 1)
C <- c(0.5, 3/2)

triangle_initial <- c(A, B, C)

liste_triangles <- divide_list_triangle(triangle_initial)

plot(xlim=c(-1,1), ylim=c(-1,3), asp=1)
plot_triangles(liste_triangles)


