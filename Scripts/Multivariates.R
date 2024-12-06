library(Maaslin2)

fit_data = Maaslin2(
  input_data = df, 
  input_metadata = df_meta, 
  min_prevalence = 0,
  transform = "NONE",
  max_significance = 0.05,
  correction = "BH",
  output = "result", 
  fixed_effects = c("institution","sex","age"), 
  reference = c("sex,Female"))  
