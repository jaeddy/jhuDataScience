pml_write_files = function(x, dirname){
    n = length(x)
    for(i in 1:n){
        filename = paste0(dirname, "problem_id_", i, ".txt")
        write.table(x[i],
                    file = filename,
                    quote = FALSE,
                    row.names = FALSE,
                    col.names = FALSE)
    }
}