.pkgenv <- new.env(parent = emptyenv())

.onLoad <- function(libname, pkgname) {
  if (!exists("julia_initialized", envir = .pkgenv)) {

    julia <- JuliaCall::julia_setup(verbose = FALSE, installJulia = TRUE)
    assign("julia_initialized", TRUE, envir = .pkgenv)
    julia_files <- list.files(system.file("julia", package = pkgname),
                              pattern = "\\.jl$", full.names = TRUE)
    for (file in julia_files) {
      JuliaCall::julia_source(file)
    }
    JuliaCall::julia_command("Base.exit_on_sigint(false)")
    reg.finalizer(.pkgenv, function(e) JuliaCall::julia_command("exit()"), onexit = TRUE)
  }
}
