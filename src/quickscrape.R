library(rvest)

if(Sys.info()[4]=="LZ2626UTPURUCKE"){
  root_dir <- file.path("c:", "git", "quickscrape")
}
  
root_data_in <- file.path(root_dir, "data_in")
root_data_out <- file.path(root_dir, "data_out")
root_src <- file.path(root_dir, "src")

#duke center for genomic and computational biology
duke_filename <- file.path(root_data_in, "view-source_https___genome.duke.edu_education_CBB_faculty.html")
duke_webpage <- "https://genome.duke.edu/education/CBB/faculty"
#NAs
duke_page <- html_session(duke_webpage)
html_nodes(duke_page, "div.email") %>% html_attr("id")
# this works
duke_text <- readLines(duke_filename)
duke_emails = unlist(regmatches(duke_text, gregexpr("([_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,4}))", 
                                                    duke_text)))
unique_duke_emails <- unique(duke_emails)

#ncsu genomic science
ncsu_webpage <- "https://brc.ncsu.edu/genomics/people/faculty"
ncsu_filename <- file.path(root_data_in, "view-source_https___brc.ncsu.edu_genomics_people_faculty.html")
#NAs
ncsu_page <- html_session(ncsu_webpage)
html_nodes(ncsu_page, "div.column-5") %>% html_attr("id") #td
# this works
ncsu_text <- readLines(ncsu_filename)
ncsu_emails = unlist(regmatches(ncsu_text, gregexpr("([_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,4}))", 
                                                    ncsu_text)))
unique_ncsu_emails <- unique(ncsu_emails)

#unc bioinformatics
unc_webpage <- "https://bcb.unc.edu/faculty/"
unc_filename <- file.path(root_data_in, "view-source_https___bcb.unc.edu_faculty_.html")
# this works
unc_text <- readLines(unc_filename)
unc_emails = unlist(regmatches(unc_text, gregexpr("([_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,4}))", 
                                                    unc_text)))
unique_unc_emails <- unique(unc_emails)

#print in way for pasting into blind cc
unique_emails <- c(unique_duke_emails, unique_ncsu_emails, unique_unc_emails)
paste(as.character(unique_emails), collapse=";")
