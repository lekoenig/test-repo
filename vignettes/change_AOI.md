
### Defining the spatial area of interest
In this workflow we define our spatial area of interest from a set of coordinates that we define in the `_targets.R` file. These coordinates represent the vertices of a simple triangle polygon that covers the spatial extent of our WQP data pull. 

We could also use existing watershed boundaries or another polygon from an external data source to define our area of interest. For example, we could replace the targets [`p1_AOI`](https://github.com/USGS-R/ds-pipelines-targets-example-wqp/blob/99a90c159bcebc4d5ac2e90fbc85734547217a4a/1_inventory.R#L40-L44) and [`p1_AOI_sf`](https://github.com/USGS-R/ds-pipelines-targets-example-wqp/blob/99a90c159bcebc4d5ac2e90fbc85734547217a4a/1_inventory.R#L47-L52) with targets that download and read in an external shapefile:  

```r
# Download a shapefile containing the Delaware River Basin boundaries
# We changed the storage format for this target to format = "file" so that tar_make() will
# track this target and automatically re-run any downstream targets if the zip file changes. 
# A file target must return a character vector indicating the path of local files and/or
# directories. Below, we include all of the code needed to build the target between {} and 
# return the variable fileout to satisfy the format = "file" requirements. Running the 
# command tar_load(p1_shp_zip) should display the string used to define fileout.
  tar_target(
    p1_shp_zip,
    {
      # mode is a character string indicating the mode used to write the file; see 
      # ??utils::download.file for details.
      fileout <- "1_inventory/out/drbbnd.zip"
      utils::download.file("https://www.state.nj.us/drbc/library/documents/GIS/drbbnd.zip",
                  destfile = fileout, 
                  mode = "wb", quiet = TRUE)
      fileout
    },
    format = "file"
  ),

# Unzip the shapefile and read in as an sf polygon object
  tar_target(
    p1_AOI_sf,
    {
      savedir <- tools::file_path_sans_ext(p1_shp_zip)
      unzip(zipfile = p1_shp_zip, exdir = savedir, overwrite = TRUE)
      sf::st_read(paste0(savedir,"/drb_bnd_arc.shp"), quiet = TRUE) %>%
        sf::st_cast(.,"POLYGON")
    }
  ),
```

<br>  