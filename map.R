#mappa costa ricaaa

# Load necessary libraries
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggrepel)
library(ggspatial)
library(colorBlindness)
cvdPlot(c("#E69F00", "#56B4E9", "#009E73", "#D55E00"))

#FINAL VERSION!!!
# Get the map of Costa Rica
costa_rica <- ne_countries(scale = "medium", country = "Costa Rica", returnclass = "sf")

# Create a data frame for your sites
sites <- data.frame(
  name = c("FAB", "LLFS", "FCEA", "GAM"),  # Site names
  lon = c(-83.48893223605518, -82.9257529032521, -82.963622851001, -83.20150803146555),  # Longitudes
  lat = c(9.020756202074873, 8.740409777327136, 8.799968738174542, 8.701355351990747 )   # Latitudes
)

# Convert the sites data to an sf object
sites_sf <- st_as_sf(sites, coords = c("lon", "lat"), crs = 4326)

# Plot the base map and add site points
Costa_rica_plot<- ggplot() +
  geom_sf(data = costa_rica, fill = "#F4F1E8",
          color = "grey20"
  ) +  # Base map
  geom_sf(data = sites_sf, aes(fill = name), color = "grey20", size = 3, shape = 21) +# Overlay sites
  scale_fill_manual(name = "Sites:",
                      values = c(
                        "FAB" = "olivedrab4", 
                        "FCEA" ="darkorange", 
                        "LLFS" = "firebrick4",
                        "GAM" = "royalblue1"
                       )) +
  annotation_scale(location = "bl", width_hint = 0.3) +  # Add scale bar
  annotation_north_arrow(location = "tr", which_north = "true",
                         style = north_arrow_fancy_orienteering) +  # Compass
  theme_classic() +
  ggtitle("Map of Costa Rica with Site Locations") +
  theme_classic() +
  theme(legend.position = c(0.13, 0.28),
        legend.background = element_rect(fill = alpha("white", 0.8)),
        legend.title = element_text(face = "bold"))
  #theme(
  #  panel.background = element_rect(fill = "#EAF2F8", color = NA)
  #)
cvdPlot(plot = last_plot(), layout = c("olivedrab4", "goldenrod2", "firebrick4", "royalblue1"))
ggsave("~/Desktop/costarica4.jpeg", plot=Costa_rica_plot, width = 5, height = 5, dpi = 800)
ggsave("~/Desktop/costaricamap.svg", plot=Costa_rica_plot)









#when have the api key
library(ggmap)

# Get a base map using ggmap
ggmap::register_google("code")
map <- get_map(location = c(lon = -98.5795, lat = 39.8283), zoom = 4)  # USA Center

# Plot with a base map
ggmap(map) +
  geom_point(data = points, aes(x = lon, y = lat, color = name), size = 3) +
  theme_minimal() +
  labs(title = "Coordinate Points on Map",
       x = "Longitude",
       y = "Latitude")

# Install the MODISTools package
install.packages("MODISTools")

# Load the package
library(MODISTools)

# Query MODIS NDVI data for a specific region 
MODISQuery(lat = 49.5, lon = 15.5, product = "MOD13Q1", collection = "006",
           start = "2020-01-01", end = "2020-12-31")

# Download the data (ensure you have registered on Earthdata and obtained a token)
MODISDownload(product = "MOD13Q1", collection = "006", lat = 49.5, lon = 15.5,
              start = "2020-01-01", end = "2020-12-31", user = "username",
              password = "password")

# Load the required package
library(MODISTools)

# Query MODIS NDVI data for a specific region (Costa Rica example)
data <- mt_subset(
  product = "MOD13Q1",        # MODIS Product
  lat = 9.7489,               # Latitude (Costa Rica)
  lon = -83.7534,             # Longitude (Costa Rica)
  band = "250m_16_days_NDVI", # Band to retrieve
  start = "2020-01-01",       # Start date
  end = "2020-12-31",         # End date
  km_lr = 0, km_ab = 0,       # No buffer (adjust for larger areas)
  site_name = "CostaRica",
  internal = TRUE
)


# Get the base map of Costa Rica
costa_rica <- ne_countries(scale = "medium", country = "Costa Rica", returnclass = "sf")

# Create a data frame for your sites
sites <- data.frame(
  name = c("FAB", "LLFS", "FCEA", "GAM"),  # Site names
  lon = c(-83.48893223605518, -82.9257529032521, -82.963622851001, -83.20150803146555),  # Longitudes
  lat = c(9.020756202074873, 8.740409777327136, 8.799968738174542, 8.701355351990747 )   # Latitudes
)

# Convert the sites data to an sf object
sites_sf <- st_as_sf(sites, coords = c("lon", "lat"), crs = 4326)

# Plot the base map and add site points
Costa_rica_plot<- ggplot() +
  geom_sf(data = costa_rica, fill = "snow2", color = "black") +  # Base map
  geom_sf(data = sites_sf, aes(color = name), size = 3) +# Overlay sites
  scale_color_manual(values = c( "FAB" = "olivedrab4", 
                                "FCEA" ="darkorange2", 
                                "LLFS" = "firebrick4",
                                "GAM" = "royalblue1"), guide = guide_legend()) +
  annotation_scale(location = "bl", width_hint = 0.3) +  # Add scale bar
  annotation_north_arrow(location = "tr", which_north = "true",
                         style = north_arrow_fancy_orienteering) +  # Compass
  theme_classic() +
  ggtitle("Map of Costa Rica with Site Locations") +
  theme(legend.position="bottom",
        legend.spacing.x = unit(0, 'cm'))+
  guides(fill = guide_legend(label.position = "bottom"))


ggsave("~/Desktop/costarica4.jpeg", plot=Costa_rica_plot, width = 5, height = 5, dpi = 300)


#ALMOST LAST METHOD
# Load libraries
library(ggmap)
library(sf)
library(ggplot2)


# Define the bounding box correctly
bbox <- c(left = -85, bottom = 8, right = -82, top = 11)

# Get a terrain-style map from OpenStreetMap (Stamen)
costa_rica_map <- get_stadiamap(bbox, zoom = 7, maptype = "stamen_terrain")

# Create a data frame for your sites
sites <- data.frame(
  name = c("FAB", "LLFS", "FCEA", "GAM"),  # Site names
  lon = c(-83.48893223605518, -82.9257529032521, -82.963622851001, -83.20150803146555),  # Longitudes
  lat = c(9.020756202074873, 8.740409777327136, 8.799968738174542, 8.701355351990747 )   # Latitudes
)

# Convert to sf object
sites_sf <- st_as_sf(sites, coords = c("lon", "lat"), crs = 4326)

# Plot the OSM map with site locations
ggmap(costa_rica_map) +
  geom_point(data = sites, aes(x = lon, y = lat, color = name), size = 3) +
  ggtitle("Map of Costa Rica with Site Locations (OSM)") +
  theme_minimal()

##LAST METHOD
# Load libraries
library(tmap)
library(tmaptools)
library(sf)
library(ggplot2)
library(OpenStreetMap)

# Define bounding box for Costa Rica
bb <- matrix(c(-85, 8, -82, 11), ncol = 2, byrow = TRUE)  # Correct format

# Use tmaptools to get the OpenStreetMap base layer
costa_rica_map <- read_osm(bb, type = "osm")  # Corrected function call

# Create a data frame for your sites
sites <- data.frame(
  name = c("FAB", "LLFS", "FCEA", "GAM"),  # Site names
  lon = c(-83.48893223605518, -82.9257529032521, -82.963622851001, -83.20150803146555),  # Longitudes
  lat = c(9.020756202074873, 8.740409777327136, 8.799968738174542, 8.701355351990747 )   # Latitudes
)

# Convert to sf object
sites_sf <- st_as_sf(sites, coords = c("lon", "lat"), crs = 4326)

# Plot the OpenStreetMap base map with site locations
tm_shape(costa_rica_map) +
  tm_rgb() +  # Use OSM map as a base layer
  tm_shape(sites_sf) +
  tm_dots(size = 0.5, col = "red") +  # Plot sites as red dots
  tm_text("name", size = 1.2, col = "black") +  # Label site names
  tm_layout(title = "Costa Rica Map with Site Locations")