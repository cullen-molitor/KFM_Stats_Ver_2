

Year_to_Filter_Data_by <- 2019 # <== CHANGE ME TO FILTER DATA <==

Export_END_Year <- 2019 # <== CHANGE ME TO REFLECT ENDING YEAR OF DATA TEXT FILE <==

{ # Library  ----
  library(tidyverse)
  library(ggpubr)
  library(glue)
  library(lubridate)
  library(rmarkdown)
  library(zoo)
  library(MASS)
  library(vegan)
  library(labdsv)
  library(lme4)
  library(car)
  library(knitr)
  library(tinytex)
  library(Cairo)
  library(ggnewscale)
  library(randomForest)
  library(pdp)
  library(broom)
  library(scales)

}
  
{ # Plot Themes   ----
  timeseries_top_theme <- function () {
    ggpubr::theme_classic2() +
      ggplot2::theme(text = element_text(color="black", family ="Cambria"),
                     plot.caption = element_text(size = 11),
                     legend.justification = c(0, 0.5),
                     legend.key.width = unit(.75, "cm"),
                     legend.title = element_text(size = 12, color = "black"),
                     legend.text = element_text(size = 11, color = "black"),
                     axis.title = element_text(size = 12, color="black"),
                     axis.text.y = element_text(size = 12, color="black"),
                     axis.text.x = element_blank(),
                     panel.grid.major= element_line())
  }
  timeseries_bottom_theme <- function (){
    ggpubr::theme_classic2() +
      ggplot2::theme(text = element_text(color="black", family ="Cambria"),
                     plot.caption = element_text(size = 13),
                     legend.justification = c(0, 0.5),
                     legend.key.width = unit(.75, "cm"),
                     legend.title = element_text(size = 12, color = "black"),
                     legend.text = element_text(size = 11, color = "black"),
                     legend.margin = unit(0.1, "cm"),
                     axis.title = element_text(size = 12, color = "black"),
                     axis.text.y = element_text(size = 12, color = "black"),
                     axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 11, color="black"),
                     axis.line.x = element_blank(),
                     panel.grid.major= element_line())
  }
  nMDS_theme <- function () {
    theme_bw() + 
      theme(plot.title = element_text(size = 10, hjust = 0.5),
            axis.text = element_blank(), 
            axis.ticks = element_blank(), 
            axis.title = element_blank(), 
            panel.background = element_blank(), 
            panel.grid.major = element_blank(),  
            panel.grid.minor = element_blank(),  
            plot.background = element_blank(),
            plot.caption = element_text(size=9, hjust = 0),
            aspect.ratio=1) 
  }
  ISA_theme <- function () {
    ggplot2::theme_bw() + 
      ggplot2::theme(plot.title = element_text(size = 16, hjust = 0.5),
                     axis.text.x = element_text(size = 10.5, color = "black", angle = 45, hjust = 1, vjust = 1),
                     axis.text.y = element_text(size = 11, color = "black", face = "italic"),
                     axis.title = element_text(size = 14),
                     legend.position = "right",
                     legend.text = element_text(size = 10, color = "black"),
                     legend.title = element_text(size = 12),
                     panel.grid.major = element_blank(),  
                     panel.grid.minor = element_blank())
  }
  Ratio_theme <- function () {
    theme_classic2() +
      theme(plot.title = element_text(hjust = 0.5, size = 16),
            panel.grid.major = element_line(),
            legend.position = "none",
            legend.justification = c(0.5,0.5),
            legend.background = element_rect(size = unit(5, "cm")),
            legend.title = element_text(size = 14, color = "black"),
            legend.text = element_text(size = 13, colour = "black"),
            axis.title = element_blank(),
            axis.text = element_text(size = 12),
            strip.text = element_text(size = 12, colour = "black", angle = 90))
  }
  Biomass_Summary_theme <- function () {
    ggplot2::theme_classic() +
      ggplot2::theme(plot.title = element_text(hjust = 0.5, size = 18),
                     plot.subtitle = element_text(hjust = 0.5, size = 16),
                     plot.caption = element_text(hjust = 0),
                     panel.border = element_rect(fill = FALSE),
                     legend.position = "bottom",
                     legend.justification = c(0.5, 0.5),
                     legend.title = element_text(size = 12, color = "black"),
                     legend.text = element_text(size = 9, color = "black"),
                     axis.title = element_text(size = 16),
                     axis.text.y = element_text(size = 12), 
                     axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 12),
                     strip.text = element_text(size = 10, colour = "black"))
  }
  Original_16_top_theme <- function () {
    ggpubr::theme_classic2() +
      ggplot2::theme(text = element_text(color="black", family ="Cambria"),
                     legend.position = "right",
                     legend.justification = c(0, 0.5),
                     legend.key.width = unit(.75, "cm"),
                     legend.title = element_text(size = 12, color = "black"),
                     legend.text = element_text(size = 11, color = "black"),
                     axis.title = element_text(hjust = .5, size = 12),
                     axis.text.y = element_text(size = 12, color="black"),
                     axis.text.x = element_blank(),
                     panel.grid.major= element_line())
  }
  Original_16_bottom_theme <- function () {
    ggpubr::theme_classic2() +
      ggplot2::theme(text = element_text(color="black", family ="Cambria"),
                     legend.position = "right",
                     legend.justification = c(0,0.5),
                     legend.key.width = unit(.75, "cm"),
                     legend.background = element_rect(size = unit(5, "cm")),
                     legend.title = element_text(size = 12, color = "black"),
                     legend.text = element_text(size = 11, colour = "black"),
                     panel.grid.major = element_line(),
                     axis.title = element_text(hjust = .5, size = 12),
                     axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 12, color="black"),
                     axis.text.y = element_text(size = 12, color="black"),
                     axis.line.x = element_blank(),
                     strip.text = element_text(size = 10, colour = "black", angle = 90))
  }
}

{ # Species and Trophic Levels   ----
  
  Species_Info <- read_csv("Meta_Data/SpeciesComplete.csv")
  Fish_Trophic_Levels <- readr::read_csv("Meta_Data/KFM_Fish_Trophic_Levels.csv")
  
  Mixed_Data_xRef <- readr::read_csv("Meta_Data/Mixed_Data_xref.csv")
  
  Benthic_Biomass_Species <- c(
    "Crassedoma giganteum", "rock scallop",
    "Haliotis rufescens", "red abalone",
    "Kelletia kelletii", "Kellet's whelk",           
    "Lithopoma gibberosa", "red turban snail", 
    "Lytechinus anamesus", "white sea urchin", 
    "Megastraea undosa", "wavy turban snail",             
    "Megathura crenulata", "giant keyhole limpet", 
    "Patiria miniata", "bat star",
    "Pisaster giganteus", "giant-spined sea star",            
    "Pycnopodia helianthoides", "sunflower star",
    "Strongylocentrotus franciscanus", "red sea urchin", 
    "Strongylocentrotus purpuratus", "purple sea urchin",
    "Tethya aurantia", "orange puffball sponge", 
    "Tegula regina", "queen tegula", 
    "Macrocystis pyrifera", "giant kelp",
    "Muricea californica", "California golden gorgonian",
    "Muricea fruticosa", "brown gorgonian",
    "Lophogorgia chilensis", "red gorgonian")
  
  Potential_Biomass_Additions <- c(
    "Astrangia lajollaensis", "Corynactis californicus",
    "Phragmatopoma californica", "Serpulorbis squamiger",
    "Diaperoecia californica")
  
  Fish_Biomass_Species <- c(
    "Caulolatilus princeps", "ocean whitefish",
    "Chromis punctipinnis", "blacksmith",
    "Embiotoca jacksoni", "black surfperch",
    "Embiotoca lateralis", "striped surfperch",
    "Girella nigricans", "opaleye",
    "Halichoeres semicinctus", "rock wrasse, female", "rock wrasse, male",     
    "Hypsypops rubicundus", "garibaldi",
    "Medialuna californiensis", "halfmoon",
    "Ophiodon elongatus", "lingcod",
    "Oxyjulis californica", "senorita",
    "Paralabrax clathratus", "kelp bass",
    "Rhacochilus toxotes", "rubberlip surfperch",
    "Rhacochilus vacca", "pile perch",
    "Scorpaena guttata", "California scorpionfish",
    "Scorpaenichthys marmoratus", "cabezon",
    "Sebastes atrovirens", "kelp rockfish",
    "Sebastes chrysomelas", "black and yellow rockfish",
    "Sebastes mystinus", "blue rockfish",  
    "Sebastes serranoides", "olive rockfish",
    "Sebastes serriceps", "treefish",
    "Semicossyphus pulcher", "California sheephead, male", "California sheephead, female")
  
  Fish_Colors <- Fish_Trophic_Levels$Color_R
  names(Fish_Colors) <- Fish_Trophic_Levels$CommonName
  
  BenthicBiomassColor <- c(
    'Lithopoma gibberosa' = "deeppink", 
    'Megastraea undosa' = "grey40", 
    'Patiria miniata' = "orange2", 
    'Strongylocentrotus franciscanus' = "red2", 
    'Strongylocentrotus purpuratus' = "darkorchid2", 
    'Tegula regina' = "yellow", 
    'Pisaster giganteus' = "deepskyblue2", 
    'Crassedoma giganteum' = "gold", 
    'Haliotis rufescens' = "firebrick1",             
    'Kelletia kelletii' = "black",
    'Lytechinus anamesus' = "grey80", 
    'Megathura crenulata' = "aquamarine2", 
    'Pycnopodia helianthoides' = "aquamarine2",       
    'Tethya aurantia' = "gold1", 
    'Macrocystis pyrifera' = "forestgreen", 
    'Lophogorgia chilensis' = "red",       
    'Muricea californica' = "gold4", 
    'Muricea fruticosa' = "brown")
  
  oneM_Biomass_Species <- c(
    "Megastraea undosa",  #  All years
    "Lithopoma gibberosa",  #  All years
    "Tegula regina", # 2006 to present (when they were added as a species)
    "Patiria miniata",  #  All years               
    "Pisaster giganteus", # 1982 - 1995 then 5 m to 2013
    "Strongylocentrotus franciscanus",  #  All years
    "Strongylocentrotus purpuratus")  #  All years
  fiveM_Biomass_Species <- c("Pisaster giganteus") # 1996 - 2013 then to Band Transects
  bands_Biomass_Species <- c(
    "Tethya aurantia", #  All years 
    "Haliotis rufescens",  #  All years
    "Kelletia kelletii",  #  All years
    "Megathura crenulata",  #  All years
    "Crassedoma giganteum", #  All years
    "Pisaster giganteus",  #  2014 - present 
    "Pycnopodia helianthoides",  #  All years
    "Lytechinus anamesus")  #  All years
  
  SpeciesColor <- c(as.character(Species_Info$Color))
  names(SpeciesColor) <- c(Species_Info$CommonName)
  SpeciesColor <- SpeciesColor[!is.na(SpeciesColor)]
}

{ # Island and Site Information   -----
  siteInfo1 <- read_csv("Meta_Data/Site_info.csv")
  
  Substrate <- readr::read_csv("Meta_Data/RPC_Substrate.csv") %>% 
    dplyr::group_by(SiteCode, ScientificName) %>% 
    dplyr::summarise(Percent_Cover = round(mean(Percent_Cover), 2)) %>% 
    tidyr::pivot_wider(names_from = ScientificName, values_from = Percent_Cover) %>% 
    dplyr::rename(`Percent Rock` = Rock,
                  `Percent Cobble` = Cobble,
                  `Percent Sand` = Sand,
                  `Site Code` = SiteCode)
  
  Site_Lat_Lon <- dplyr::select(siteInfo1, SiteCode, Latitude, Longitude, Reference, MeanDepth) %>% 
    dplyr::rename(`Site Code` = SiteCode)
  
  Site_Table <- readr::read_csv("Meta_Data/Site_Table.csv") %>% 
    dplyr::left_join(Site_Lat_Lon) %>% 
    dplyr::left_join(Substrate) %>% 
    dplyr::select(
      `Site Number`, `Island Name`, `Site Name`, `Depth Range`, `Year Established`, 
      `Year MPA Established`, Reference, `Depth Range`, Latitude, Longitude, 
      `Percent Rock`, `Percent Cobble`, `Percent Sand`) %>% 
    dplyr::rename(`Site #` = `Site Number`,
                  `Est.` = `Year Established`,
                  `MPA Est.` = `Year MPA Established`)
  
  Island_Colors <- c("San Miguel" = "darkmagenta", "SM" = "darkmagenta", 
                     "Santa Rosa" = "dodgerblue4", "SR" = "dodgerblue4", 
                     "Santa Cruz" = "forestgreen", "SC" = "forestgreen", 
                     "Anacapa" = "darkorange", "AN" = "darkorange", 
                     "Santa Barbara" = "firebrick2","SB" = "firebrick2", 
                     "Inside" = "green", "Outside" = "red") 
  
  IslandLevels <- c(
    "San Miguel", "Santa Rosa", "Santa Cruz", "Anacapa",  "Santa Barbara")
  IslandLevelsFull <- c(
    "San Miguel Island", "Santa Rosa Island", "Santa Cruz Island", "Anacapa Island",  "Santa Barbara Island")
  MPA_Levels <- c("Santa Rosa", "Santa Cruz", "Anacapa",  "Santa Barbara")
  multipatt_island_list <- c(rep("AN", 3), rep("SB", 3), rep("SC", 3), rep("SR", 3))
  
  SiteLevels <- c(
    # San Miguel
    "Wyckoff Ledge", "Miracle Mile", # Out
    "Hare Rock", # In
    # Santa Rosa
    "Johnson's Lee North", "Johnson's Lee South", "Rodes Reef", "Cluster Point", # Out
    "Trancion Canyon", "Chickasaw", "South Point", # In
    # Santa Cruz
    "Fry's Harbor", "Pelican Bay", "Yellow Banks", "Devil's Peak Member", "Pedro Reef", "Little Scorpion", # Out
    "Gull Island South", "Scorpion Anchorage", "Potato Pasture", "Cavern Point",  # In
    # Anacapa
    "Admiral's Reef", "East Fish Camp", "Lighthouse",  # Out
    "Cathedral Cove" , "Landing Cove", "Black Sea Bass Reef", "Keyhole",  # In
    # Santa Barbara
    "Arch Point", "Cat Canyon", "Webster's Arch",  # Out
    "SE Sea Lion Rookery", "Graveyard Canyon", "Southeast Reef") # In
  
  SiteColor <- as.character(siteInfo1$Color)
  names(SiteColor) <- siteInfo1$SiteName
  
  SiteLine <- siteInfo1$LineType
  names(SiteLine) <- siteInfo1$SiteName
}

{ # Protocol Tables  ----
  Species_Protocol_Table <- readr::read_csv("Meta_Data/Species_Protocol_Complete.csv")
  
  Best_Protocol_Table <- readr::read_csv("Meta_Data/Species_Best_Protocol.csv")
  
  Protocol_Table <- readr::read_csv("Meta_Data/Protocols.csv")
}

{ # Dive meta data  ----
  Dive_Meta_Data <- readr::read_csv("Meta_Data/Dive_Totals.csv")
  
  Total_Dives <- sum(Dive_Meta_Data$Dives)
  
  Divers <- mean(Dive_Meta_Data$Divers)
  
  Dive_Time <- sum(Dive_Meta_Data$Dive_Hours)
  
  Vessel_Time <- sum(Dive_Meta_Data$Vessel_Days)
  
}

{ # Biomass Conversion Tables With Sources -----
  
  # Non-LaTex for easier mnipulation
  Benthic_Biomass_Coversions <- readr::read_csv("Meta_Data/Benthic_Biomass_Equations.csv")
  Fish_Biomass_Coversions <- readr::read_csv("Meta_Data/Fish_Biomass_Coversions.csv") 
  
  # LaTex Tables for nice knitr::kable outputs with equations and numbers looking pretty
  Benthic_Biomass_Coversions_Latex <- readr::read_csv("Meta_Data/Benthic_Biomass_Equations_Latex.csv") 
  Fish_Biomass_Coversions_Latex <- readr::read_csv("Meta_Data/Fish_Biomass_Coversions_Latex.csv")
  
}

{ # Date vectors   ----
  
  MonthLevels <- c('May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr')
  
  season_months <- c("May", "June", "July", "August", "September", "October")  
}

{ # SST Anomaly ONI and PDO  ----
  SST_Anomaly_Orig16_Index <- readr::read_csv("Tidy_Data_Dont_Touch/SST_Anomaly_Index.csv") 
  SST_Anomaly_Index <- SST_Anomaly_Orig16_Index %>%
    dplyr::filter(SurveyYear > 2004)
  
  annual_mean_oni <- SST_Anomaly_Index %>% 
    dplyr::select(SurveyYear, Mean_ONI_ANOM) %>% 
    dplyr::distinct(SurveyYear, .keep_all = TRUE)
  
  annual_mean_pdo <- SST_Anomaly_Index %>% 
    dplyr::select(SurveyYear, Mean_PDO_ANOM) %>% 
    dplyr::distinct(SurveyYear, .keep_all = TRUE)
}

{ # Benthic Site level Counts   ----
  Benthic_Counts_Wide <- readr::read_csv("Tidy_Data_Dont_Touch/Benthic_Counts.csv")
}

{ # Benthic Densities   ----
  # used for plotting species which don't have biomass estimates eg lobster
  Benthic_Densities_Wide <- readr::read_csv("Tidy_Data_Dont_Touch/Benthic_Densities.csv") %>%
    mutate(IslandName = gsub(" Island", "", IslandName),
           IslandName = factor(IslandName, levels = MPA_Levels),
           Date = base::as.Date(base::ISOdate(SurveyYear, 1, 1)))
}

{ # Fish Site level Counts ----
  Fish_Counts_Wide <- readr::read_csv("Tidy_Data_Dont_Touch/Fish_Counts.csv")
}

{ # Benthic Plus Fish Counts for Diversity  ----
  All_Community_Counts_Wide <- Fish_Counts_Wide %>%
    full_join(Benthic_Counts_Wide) %>%
    mutate(IslandName = gsub(" Island", "", IslandName),
           IslandName = factor(IslandName, levels = MPA_Levels))
}

{ # Benthic Biomass Wide for Models ----
  Benthic_Biomass_Wide <- readr::read_csv("Tidy_Data_Dont_Touch/Benthic_Biomass_Wide.csv")  %>% 
    dplyr::mutate(Date = base::as.Date(base::ISOdate(SurveyYear, 1, 1)))
}

{ # Benthic Biomass Long for Plots  ----
  Benthic_Biomass_Long <- readr::read_csv("Tidy_Data_Dont_Touch/Benthic_Biomass_Long.csv") %>% 
    dplyr::mutate(IslandName = factor(IslandName, levels = MPA_Levels))
}

{ # Original 16 Data  ----
  Original_16_Biomass_Data <- readr::read_csv("Tidy_Data_Dont_Touch/Original_16_Benthic_Biomass_Long.csv")
  Original_16_Density_Data <- readr::read_csv("Tidy_Data_Dont_Touch/Original_16_Benthic.csv") 
  Original_16_VFT_Data <- readr::read_csv("Tidy_Data_Dont_Touch/Original_16_Fish_Counts.csv") 
  Original_16_rpcs_Data <- readr::read_csv("Tidy_Data_Dont_Touch/Original_16_Percent_Cover.csv")
}

{ # Fish Biomass Wide for Models   ----
  Fish_Biomass_Wide <- readr::read_csv("Tidy_Data_Dont_Touch/Fish_Biomass_Wide.csv") %>% 
    dplyr::mutate(IslandName = factor(IslandName, levels = MPA_Levels),
                  Date = base::as.Date(base::ISOdate(SurveyYear, 1, 1)))
}

{ # Fish Biomass Long for Plots  ----
  Fish_Biomass_Long <- readr::read_csv("Tidy_Data_Dont_Touch/Fish_Biomass_Long.csv") %>% 
    dplyr::mutate(IslandName = factor(IslandName, levels = MPA_Levels),
                  CommonName = factor(CommonName))
}

{ # RPCs Percent Cover Wide  ----
  RPC_Cover_Wide <- readr::read_csv("Tidy_Data_Dont_Touch/rpcs_Percent_Cover_Wide.csv") %>%
    dplyr::mutate(IslandName = gsub(" Island", "", IslandName), 
                  Date = base::as.Date(base::ISOdate(SurveyYear, 1, 1))) %>%
    dplyr::left_join(annual_mean_oni, by = c("SurveyYear"))
  names(RPC_Cover_Wide) <- str_replace_all(names(RPC_Cover_Wide), c(" " = "_" , "," = "" ))
  
}

{ # Shannon Index Calculation   ----
  ShannonIndex <- All_Community_Counts_Wide %>%
    dplyr::select(-IslandCode, -IslandName, -SiteCode, -SiteName, 
                  -SurveyYear, -ReserveStatus) %>%
    vegan::diversity()
  
  Diversity <- dplyr::select(All_Community_Counts_Wide, IslandCode, IslandName,
                             SiteCode, SiteName, SurveyYear, ReserveStatus) %>%
    cbind("Shannon_Index" = ShannonIndex) %>%
    dplyr::mutate(Date = base::as.Date(base::ISOdate(SurveyYear, 1, 1)),
                  ReserveStatus = factor(ReserveStatus),
                  IslandName = factor(IslandName, levels = MPA_Levels),
                  IslandName = gsub(" Island", "", IslandName)) %>%
    dplyr::left_join(annual_mean_oni, by = c("SurveyYear"))
}  

{ # 1-Simpsons Index Calculation and Analyses ----
  SimpsonIndex <- RPC_Cover_Wide %>%
    dplyr::select(-IslandCode, -IslandName, -SiteCode, -SiteName, 
                  -SurveyYear, -ReserveStatus, -Date, -Mean_ONI_ANOM) %>%
    vegan::diversity(index= "simpson")
  
  Simp_Diversity <- dplyr::select(RPC_Cover_Wide, IslandCode, IslandName,
                                  SiteCode, SiteName, SurveyYear, ReserveStatus) %>%
    cbind("Simpson_Index" = SimpsonIndex) %>%
    dplyr::mutate(Date = base::as.Date(base::ISOdate(SurveyYear, 1, 1)),
                  IslandName = gsub(" Island", "", IslandName),
                  IslandName = factor(IslandName, levels = MPA_Levels)) %>%
    dplyr::left_join(annual_mean_oni, by = c("SurveyYear"))
}  

{ # Mixed Data For Random Forest Model     ----
  # (% cover, Count, Biomass, Shannon Index, Simpson Index) 
  
  All_Mixed_Data_Wide <- readr::read_csv("Tidy_Data_Dont_Touch/All_Mixed_Data_Wide.csv") %>% 
    dplyr::left_join(dplyr::select(
      Diversity, SurveyYear, SiteCode, Shannon_Index)) %>% 
    dplyr::left_join(dplyr::select(
      Simp_Diversity, SurveyYear, SiteCode, Simpson_Index))
}

{ # Regression Tables  -----
  Fish_Regression_Table <- readr::read_csv("Meta_Data/Fish_Regression_Table.csv") %>% 
    dplyr::rename(coefficient = estimate) %>% 
    dplyr::select(
      CommonName, IslandName, coefficient, df, std.error, p.value, adj.r.squared) 
  
  Benthic_Regression_Table <- readr::read_csv("Meta_Data/Benthic_Regression.csv") %>% 
    dplyr::rename(coefficient = estimate) %>% 
    dplyr::select(
      CommonName, ReserveStatus, coefficient, df, std.error, p.value, adj.r.squared) 
  
  Gorgonian_Regression_Table <- readr::read_csv("Meta_Data/Gorgonian_Regression.csv") %>% 
    dplyr::rename(coefficient = estimate) %>% 
    dplyr::select(
      CommonName, IslandName, coefficient, df, std.error, p.value, adj.r.squared) 
}

{ # GLMM Models ----
  
  { # Model Formulas  -----
    Models_Fromulas <- readr::read_csv("Meta_Data/GLMM_table.csv")
  }
  
  { # Diversity Models  ----
    
    div <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Diversity,
        shannon_2005 ~ ReserveStatus * IslandCode + (1 | SurveyYear)))
    
    simpsons <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Simp_Diversity,
        (1-SimpsonIndex) ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
  } 
  
  { # Benthic Biomass Analyses   ---- 
    # comparing biomass by MPA status, Island, ONI, and MPA-Island (analogous to diversity models)
    
    fsc <- car::Anova(
      test = "F", 
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Macrocystis_pyrifera ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear), 
      ))
    
    strpur <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Strongylocentrotus_purpuratus ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    mesfra <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Strongylocentrotus_franciscanus ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    pisgig <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Pisaster_giganteus ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    pychel <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Pycnopodia_helianthoides ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    patmin <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Patiria_miniata ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    halruf <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Haliotis_rufescens ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    tetaur <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Tethya_aurantia ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    kelwel <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Kelletia_kelletii ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    lytana <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Biomass_Wide,
        Lytechinus_anamesus ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
  }
  
  { # Fish Biomass Analyses   ---- 
    
    hyprub <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Fish_Biomass_Wide,
        garibaldi ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    halsem_m <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Fish_Biomass_Wide,
        rock_wrasse_male ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    halsem_f <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Fish_Biomass_Wide,
        rock_wrasse_female ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    halsem_m <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Fish_Biomass_Wide,
        rock_wrasse_male ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    sempul_m <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Fish_Biomass_Wide,
        California_sheephead_male ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    sempul_f <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Fish_Biomass_Wide,
        California_sheephead_female ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    parcla <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Fish_Biomass_Wide,
        kelp_bass ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
  }
  
  { # Benthic Count Analyses   ---- 
    # comparing density by MPA status, Island, ONI, and MPA-Island - same as above but for species without biomass estimates (eg lobster, gorgonians, etc)
    
    palint <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Densities_Wide,
        Panulirus_interruptus ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    cencor <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Densities_Wide,
        Centrostephanus_coronatus ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    lopchi <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Densities_Wide,
        Lophogorgia_chilensis ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    parpar <- car::Anova(
      test = "F",
      lme4::lmer(
        data = Benthic_Densities_Wide,
        Parastichopus_parvimensis ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
  }
  
  { # Percent Cover Analyses   ---- 
    # comparing cover by MPA status, Island, ONI, and MPA-Island - same as above but for RPC data
    
    cystoseira <- car::Anova(
      test = "F",
      lme4::lmer(
        data = RPC_Cover_Wide,
        Cystoseira ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
    
    artic <- car::Anova(
      test = "F",
      lme4::lmer(
        data = RPC_Cover_Wide,
        articulated_coralline_algae ~ ReserveStatus * IslandCode + Mean_ONI_ANOM + (1 | SurveyYear)))
  } 
  
  { # P values for text  ----
    div_MPA_p_val <- round(div$`Pr(>F)`[[1]], 3)
    div_Isl_p_val <- round(div$`Pr(>F)`[[2]], 3)
    div_ONI_p_val <- round(div$`Pr(>F)`[[3]], 3)
    div_MPA_Isl_p_val <- round(div$`Pr(>F)`[[4]], 3)
    
    sim_MPA_p_val <- round(simpsons$`Pr(>F)`[[1]], 3)
    sim_Isl_p_val <- round(simpsons$`Pr(>F)`[[2]], 3)
    sim_ONI_p_val <- round(simpsons$`Pr(>F)`[[3]], 3)
    sim_MPA_Isl_p_val <- round(simpsons$`Pr(>F)`[[4]], 3)
    
    fsc_MPA_p_val <- round(fsc$`Pr(>F)`[[1]], 3)
    fsc_Isl_p_val <- round(fsc$`Pr(>F)`[[2]], 3)
    fsc_ONI_p_val <- round(fsc$`Pr(>F)`[[3]], 3)
    fsc_MPA_Isl_p_val <- round(fsc$`Pr(>F)`[[4]], 3)
    
    strpur_MPA_p_val <- round(strpur$`Pr(>F)`[[1]], 3)
    strpur_Isl_p_val <- round(strpur$`Pr(>F)`[[2]], 3)
    strpur_ONI_p_val <- round(strpur$`Pr(>F)`[[3]], 3)
    strpur_MPA_Isl_p_val <- round(strpur$`Pr(>F)`[[4]], 3)
    
    mesfra_MPA_p_val <- round(mesfra$`Pr(>F)`[[1]], 3)
    mesfra_Isl_p_val <- round(mesfra$`Pr(>F)`[[2]], 3)
    mesfra_ONI_p_val <- round(mesfra$`Pr(>F)`[[3]], 3)
    mesfra_MPA_Isl_p_val <- round(mesfra$`Pr(>F)`[[4]], 3)
    
    pisgig_MPA_p_val <- round(pisgig$`Pr(>F)`[[1]], 3)
    pisgig_Isl_p_val <- round(pisgig$`Pr(>F)`[[2]], 3)
    pisgig_ONI_p_val <- round(pisgig$`Pr(>F)`[[3]], 3)
    pisgig_MPA_Isl_p_val <- round(pisgig$`Pr(>F)`[[4]], 3)
    
    pychel_MPA_p_val <- round(pychel$`Pr(>F)`[[1]], 3)
    pychel_Isl_p_val <- round(pychel$`Pr(>F)`[[2]], 3)
    pychel_ONI_p_val <- round(pychel$`Pr(>F)`[[3]], 3)
    pychel_MPA_Isl_p_val <- round(pychel$`Pr(>F)`[[4]], 3)
    
    patmin_MPA_p_val <- round(patmin$`Pr(>F)`[[1]], 3)
    patmin_Isl_p_val <- round(patmin$`Pr(>F)`[[2]], 3)
    patmin_ONI_p_val <- round(patmin$`Pr(>F)`[[3]], 3)
    patmin_MPA_Isl_p_val <- round(patmin$`Pr(>F)`[[4]], 3)
    
    halruf_MPA_p_val <- round(halruf$`Pr(>F)`[[1]], 3)
    halruf_Isl_p_val <- round(halruf$`Pr(>F)`[[2]], 3)
    halruf_ONI_p_val <- round(halruf$`Pr(>F)`[[3]], 3)
    halruf_MPA_Isl_p_val <- round(halruf$`Pr(>F)`[[4]], 3)
    
    tetaur_MPA_p_val <- round(tetaur$`Pr(>F)`[[1]], 3)
    tetaur_Isl_p_val <- round(tetaur$`Pr(>F)`[[2]], 3)
    tetaur_ONI_p_val <- round(tetaur$`Pr(>F)`[[3]], 3)
    tetaur_MPA_Isl_p_val <- round(tetaur$`Pr(>F)`[[4]], 3)
    
    kelwel_MPA_p_val <- round(kelwel$`Pr(>F)`[[1]], 3)
    kelwel_Isl_p_val <- round(kelwel$`Pr(>F)`[[2]], 3)
    kelwel_ONI_p_val <- round(kelwel$`Pr(>F)`[[3]], 3)
    kelwel_MPA_Isl_p_val <- round(kelwel$`Pr(>F)`[[4]], 3)
    
    lytana_MPA_p_val <- round(lytana$`Pr(>F)`[[1]], 3)
    lytana_Isl_p_val <- round(lytana$`Pr(>F)`[[2]], 3)
    lytana_ONI_p_val <- round(lytana$`Pr(>F)`[[3]], 3)
    lytana_MPA_Isl_p_val <- round(lytana$`Pr(>F)`[[4]], 3)
    
    hyprub_MPA_p_val <- round(hyprub$`Pr(>F)`[[1]], 3)
    hyprub_Isl_p_val <- round(hyprub$`Pr(>F)`[[2]], 3)
    hyprub_ONI_p_val <- round(hyprub$`Pr(>F)`[[3]], 3)
    hyprub_MPA_Isl_p_val <- round(hyprub$`Pr(>F)`[[4]], 3)
    
    halsem_f_MPA_p_val <- round(halsem_f$`Pr(>F)`[[1]], 3)
    halsem_f_Isl_p_val <- round(halsem_f$`Pr(>F)`[[2]], 3)
    halsem_f_ONI_p_val <- round(halsem_f$`Pr(>F)`[[3]], 3)
    halsem_f_MPA_Isl_p_val <- round(halsem_f$`Pr(>F)`[[4]], 3)
    
    halsem_m_MPA_p_val <- round(halsem_m$`Pr(>F)`[[1]], 3)
    halsem_m_Isl_p_val <- round(halsem_m$`Pr(>F)`[[2]], 3)
    halsem_m_ONI_p_val <- round(halsem_m$`Pr(>F)`[[3]], 3)
    halsem_m_MPA_Isl_p_val <- round(halsem_m$`Pr(>F)`[[4]], 3)
    
    sempul_m_MPA_p_val <- round(sempul_m$`Pr(>F)`[[1]], 3)
    sempul_m_Isl_p_val <- round(sempul_m$`Pr(>F)`[[2]], 3)
    sempul_m_ONI_p_val <- round(sempul_m$`Pr(>F)`[[3]], 3)
    sempul_m_MPA_Isl_p_val <- round(sempul_m$`Pr(>F)`[[4]], 3)
    
    parcla_MPA_p_val <- round(parcla$`Pr(>F)`[[1]], 3)
    parcla_Isl_p_val <- round(parcla$`Pr(>F)`[[2]], 3)
    parcla_ONI_p_val <- round(parcla$`Pr(>F)`[[3]], 3)
    parcla_MPA_Isl_p_val <- round(parcla$`Pr(>F)`[[4]], 3)
    
    palint_MPA_p_val <- round(palint$`Pr(>F)`[[1]], 3)
    palint_Isl_p_val <- round(palint$`Pr(>F)`[[2]], 3)
    palint_ONI_p_val <- round(palint$`Pr(>F)`[[3]], 3)
    palint_MPA_Isl_p_val <- round(palint$`Pr(>F)`[[4]], 3)
    
    parpar_MPA_p_val <- round(parpar$`Pr(>F)`[[1]], 3)
    parpar_Isl_p_val <- round(parpar$`Pr(>F)`[[2]], 3)
    parpar_ONI_p_val <- round(parpar$`Pr(>F)`[[3]], 3)
    parpar_MPA_Isl_p_val <- round(parpar$`Pr(>F)`[[4]], 3)
    
    lopchi_MPA_p_val <- round(lopchi$`Pr(>F)`[[1]], 3)
    lopchi_Isl_p_val <- round(lopchi$`Pr(>F)`[[2]], 3)
    lopchi_ONI_p_val <- round(lopchi$`Pr(>F)`[[3]], 3)
    lopchi_MPA_Isl_p_val <- round(lopchi$`Pr(>F)`[[4]], 3)
    
    cencor_MPA_p_val <- round(cencor$`Pr(>F)`[[1]], 3)
    cencor_Isl_p_val <- round(cencor$`Pr(>F)`[[2]], 3)
    cencor_ONI_p_val <- round(cencor$`Pr(>F)`[[3]], 3)
    cencor_MPA_Isl_p_val <- round(cencor$`Pr(>F)`[[4]], 3)
    
    cysto_MPA_p_val <- round(cystoseira$`Pr(>F)`[[1]], 3)
    cysto_Isl_p_val <- round(cystoseira$`Pr(>F)`[[2]], 3)
    cysto_ONI_p_val <- round(cystoseira$`Pr(>F)`[[3]], 3)
    cysto_MPA_Isl_p_val <- round(cystoseira$`Pr(>F)`[[4]], 3)
    
    artic_MPA_p_val <- round(artic$`Pr(>F)`[[1]], 3)
    artic_Isl_p_val <- round(artic$`Pr(>F)`[[2]], 3)
    artic_ONI_p_val <- round(artic$`Pr(>F)`[[3]], 3)
    artic_MPA_Isl_p_val <- round(artic$`Pr(>F)`[[4]], 3)
    
  }
  
}



