#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
library(dplyr)
library(vroom)
#Read Data
dataset=vroom::vroom('inst/extdata/CTSC3704GP4GenotypeP-FXTASEventSequence10_DATA_2022-11-01_2027.csv',
                  col_types = cols(
                    dem_date = col_date(),
                    # dob = col_date(), # auto-removed
                    subj_id = col_character(),
                    redcap_event_name = col_character(),
                    sex = col_double(),
                    visit_age = col_double(),
                    mol_apoe = col_character(),
                    mol_dna_result = col_character(),
                    new_mds_psy_drug = col_double(),
                    new_mds_psy_drug_notes = col_character(),
                    new_mds_psy_drug_marij = col_double(),
                    new_mds_psy_alco = col_double(),
                    new_mds_psy_dri = col_double(),
                    new_mds_med_thyca = col_double(),
                    new_mds_med_skin = col_double(),
                    new_mds_med_mela = col_double(),
                    new_mds_med_proca = col_double(),
                    new_mds_med_sur1 = col_character(),
                    new_mds_med_sur2 = col_character(),
                    new_mds_med_sur3 = col_character(),
                    new_mds_med_sur4 = col_character(),
                    new_mds_med_sur5 = col_character(),
                    new_mds_neu_trem_int = col_double(),
                    new_mds_neu_trem_rest = col_double(),
                    new_mds_neu_trem_pos = col_double(),
                    new_mds_neu_trem_irm = col_double(),
                    new_mds_neu_trem_age = col_double(),
                    new_mds_neu_trem_head = col_double(),
                    new_mds_neu_trem_age2 = col_character(),
                    new_mds_neu_atax = col_double(),
                    new_mds_neu_atax_age = col_double(),
                    new_mds_ne_ga = col_double(),
                    new_mds_ne_gas = col_double(),
                    new_mds_med_park = col_double(),
                    new_mds_ne_pf = col_double(),
                    new_mds_ne_pfmf = col_double(),
                    new_mds_ne_pfit = col_double(),
                    new_mds_ne_pfprt = col_double(),
                    new_mds_ne_pfsg = col_double(),
                    new_mds_fxtas_stage = col_double(),
                    bds2_score = col_double(),
                    mmse_totalscore = col_double(),
                    scid_dxcode1 = col_double(),
                    scid_dx1age = col_double(),
                    scid_dxcode2 = col_double(),
                    scid_dx2age = col_double(),
                    scid_dxcode3 = col_double(),
                    scid_dx3age = col_double(),
                    scl_s_som_ts = col_double(),
                    scl_s_oc_ts = col_double(),
                    scl_s_is_ts = col_double(),
                    scl_s_dep_ts = col_double(),
                    scl_s_anx_ts = col_double(),
                    scl_s_hos_ts = col_double(),
                    scl_s_phob_ts = col_double(),
                    scl_s_par_ts = col_double(),
                    scl_s_psy_ts = col_double(),
                    scl_s_gsi_ts = col_double(),
                    scl_s_psdi_ts = col_double(),
                    scl_s_pst_ts = col_double(),
                    wais4_verbcomp_cs = col_double(),
                    wais4_percorg_cs = col_double(),
                    wais4_workmem_cs = col_double(),
                    wais4_procspeed_cs = col_double(),
                    wais4_fullscale_cs = col_double(),
                    cantab_ots_probsolvedfirstchoice_ = col_double(),
                    cantab_pal_toterrors_adjusted = col_double(),
                    cantab_sst_medianrt_gotrials = col_double(),
                    cantab_rvp_a = col_double(),
                    cantab_rti_5choice_movement = col_double(),
                    cantab_swm_between_errors = col_double(),
                    new_mds_med_lup = col_double(),
                    new_mds_med_ra = col_double(),
                    new_mds_med_mswk = col_double(),
                    new_mds_med_ana = col_double(),
                    new_mds_med_sjo = col_double(),
                    new_mds_med_ray = col_double(),
                    new_mds_med_pulm = col_double(),
                    new_mds_med_immun_notes = col_character(),
                    mri_cere_atr = col_double(),
                    mri_cerebel_atr = col_double(),
                    mri_cere_wm_hyper = col_double(),
                    mri_cerebel_wm_hyper = col_double(),
                    mri_mcp_wm_hyper = col_double(),
                    mri_pons_wm_hyper = col_double(),
                    mri_subins_wm_hyper = col_double(),
                    mri_peri_wm_hyper = col_double(),
                    mri_splen_wm_hyper = col_double(),
                    mri_genu_wm_hyper = col_double(),
                    mri_corp_call_thick = col_double(),
                    new_ds_crx1 = col_character(),
                    new_ds_crx2 = col_character(),
                    new_ds_crx3 = col_character(),
                    new_ds_crx4 = col_character(),
                    new_ds_crx5 = col_character(),
                    new_ds_crx6 = col_character(),
                    new_ds_crx7 = col_character(),
                    new_ds_crx8 = col_character(),
                    new_ds_crx9 = col_character(),
                    new_ds_crx10 = col_character(),
                    .delim = ","
                  ))


#Setting Factors
dataset$redcap_event_name = factor(dataset$redcap_event_name,levels=c("gp4__visit_1_arm_1","gp4__visit_2_arm_1","gp4__visit_3_arm_1","gp4__visit_4_arm_1","gp4__single_visit_arm_1","gp4__participant_s_arm_1"))
dataset$sex = factor(dataset$sex,levels=c("0","1"))
dataset$new_mds_psy_drug = factor(dataset$new_mds_psy_drug,levels=c("0","1","2","999","888","777"))
dataset$new_mds_psy_drug_marij = factor(dataset$new_mds_psy_drug_marij,levels=c("0","1","2","999","888","777"))
dataset$new_mds_psy_alco = factor(dataset$new_mds_psy_alco,levels=c("0","1","2","999","888","777"))
dataset$new_mds_med_thyca = factor(dataset$new_mds_med_thyca,levels=c("0","1","999","888","777"))
dataset$new_mds_med_skin = factor(dataset$new_mds_med_skin,levels=c("0","1","999","888","777"))
dataset$new_mds_med_mela = factor(dataset$new_mds_med_mela,levels=c("0","1","999","888","777"))
dataset$new_mds_med_proca = factor(dataset$new_mds_med_proca,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_int = factor(dataset$new_mds_neu_trem_int,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_rest = factor(dataset$new_mds_neu_trem_rest,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_pos = factor(dataset$new_mds_neu_trem_pos,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_irm = factor(dataset$new_mds_neu_trem_irm,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_head = factor(dataset$new_mds_neu_trem_head,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_atax = factor(dataset$new_mds_neu_atax,levels=c("0","1","999","888","777"))
dataset$new_mds_ne_ga = factor(dataset$new_mds_ne_ga,levels=c("0","1","999","777"))
dataset$new_mds_med_park = factor(dataset$new_mds_med_park,levels=c("0","1","999","888","777"))
dataset$new_mds_ne_pf = factor(dataset$new_mds_ne_pf,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfmf = factor(dataset$new_mds_ne_pfmf,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfit = factor(dataset$new_mds_ne_pfit,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfprt = factor(dataset$new_mds_ne_pfprt,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfsg = factor(dataset$new_mds_ne_pfsg,levels=c("0","1","999","777"))
dataset$scid_dxcode1 = factor(dataset$scid_dxcode1,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$scid_dxcode2 = factor(dataset$scid_dxcode2,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$scid_dxcode3 = factor(dataset$scid_dxcode3,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$new_mds_med_lup = factor(dataset$new_mds_med_lup,levels=c("0","1","999","888","777"))
dataset$new_mds_med_ra = factor(dataset$new_mds_med_ra,levels=c("0","1","999","888","777"))
dataset$new_mds_med_mswk = factor(dataset$new_mds_med_mswk,levels=c("0","1","999","888","777"))
dataset$new_mds_med_ana = factor(dataset$new_mds_med_ana,levels=c("0","1","3","999","888","777"))
dataset$new_mds_med_sjo = factor(dataset$new_mds_med_sjo,levels=c("0","1","999","888","777"))
dataset$new_mds_med_ray = factor(dataset$new_mds_med_ray,levels=c("0","1","999","888","777"))
dataset$new_mds_med_pulm = factor(dataset$new_mds_med_pulm,levels=c("0","1","999","888","777"))
dataset$mri_cere_atr = factor(dataset$mri_cere_atr,levels=c("0","1","3","4","999"))
dataset$mri_cerebel_atr = factor(dataset$mri_cerebel_atr,levels=c("0","1","3","4","999"))
dataset$mri_cere_wm_hyper = factor(dataset$mri_cere_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_cerebel_wm_hyper = factor(dataset$mri_cerebel_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_mcp_wm_hyper = factor(dataset$mri_mcp_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_pons_wm_hyper = factor(dataset$mri_pons_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_subins_wm_hyper = factor(dataset$mri_subins_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_peri_wm_hyper = factor(dataset$mri_peri_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_splen_wm_hyper = factor(dataset$mri_splen_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_genu_wm_hyper = factor(dataset$mri_genu_wm_hyper,levels=c("0","1","999"))
dataset$mri_corp_call_thick = factor(dataset$mri_corp_call_thick,levels=c("0","1","999"))
dataset$dem_race = factor(dataset$dem_race,levels=c("1","2","3","4","5","8","6","7"))
dataset$dem_eth = factor(dataset$dem_eth,levels=c("1","2","3"))
dataset$new_mds_psy_dri = factor(dataset$new_mds_psy_dri)
# levels(dataset$new_mds_psy_dri) = levels(dataset$new_mds_psy_dri) |> sub(pattern = "888", "")

levels(dataset$redcap_event_name)=c("GP4 - Visit 1","GP4 - Visit 2","GP4 - Visit 3","GP4 - Visit 4","GP4 - Single Visit","GP4 - Participant Survey")
levels(dataset$sex)=c("Female","Male")
levels(dataset$new_mds_psy_drug)=c("None","Past Only","Present","no response","NA","question not asked at time of data entry; check records")
levels(dataset$new_mds_psy_drug_marij)=c("None","Past Only","Present","no response","NA","question not asked at time of data entry; check records")
levels(dataset$new_mds_psy_alco)=c("None","Past Only","Present","no response","NA","question not asked at time of data entry; check records")
levels(dataset$new_mds_med_thyca)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_skin)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_mela)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_proca)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_neu_trem_int)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_neu_trem_rest)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_neu_trem_pos)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_neu_trem_irm)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_neu_trem_head)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_neu_atax)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_ne_ga)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_park)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_ne_pf)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(dataset$new_mds_ne_pfmf)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(dataset$new_mds_ne_pfit)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(dataset$new_mds_ne_pfprt)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(dataset$new_mds_ne_pfsg)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(dataset$scid_dxcode1)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(dataset$scid_dxcode2)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(dataset$scid_dxcode3)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(dataset$new_mds_med_lup)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_ra)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_mswk)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_ana)=c("No","Yes","Unknown","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_sjo)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_ray)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$new_mds_med_pulm)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(dataset$mri_cere_atr)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_cerebel_atr)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_cere_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_cerebel_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_mcp_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_pons_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_subins_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_peri_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_splen_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_genu_wm_hyper)=c("No","Yes","Missing/Refused")
levels(dataset$mri_corp_call_thick)=c("Normal","Thin","Missing/Refused")
levels(dataset$dem_race)=c("American Indian/Alaska Native","Asian","Black or African American","Native Hawaiian or Other Pacific Islander","White","Australian Aborigine","More Than One Race","Unknown / Not Reported")
levels(dataset$dem_eth)=c("Hispanic or Latino","NOT Hispanic or Latino","Unknown / Not Reported")

#Setting Labels

labels = c(subj_id = "FXS ID",
           redcap_event_name = "Event Name",
           sex = "Gender",
           visit_age = "Age at visit",
           mol_apoe = "ApoE",
           mol_dna_result = "Floras Non-Sortable Allele Size (CGG) Results",
           new_mds_psy_drug = "Drug use",
           new_mds_psy_drug_notes = "Drugs used",
           new_mds_psy_drug_marij = "Marijuana use",
           new_mds_psy_alco = "Alcohol abuse",
           new_mds_psy_dri = "# of drinks per day now", #range= 0-20; -2= < 1/day; 999= no response
           new_mds_med_thyca = "Thyroid Cancer",
           new_mds_med_skin = "Skin Cancer",
           new_mds_med_mela = "Melanoma",
           new_mds_med_proca = "Prostate Cancer",
           new_mds_med_sur1 = "Surgery: Type/Age",
           new_mds_med_sur2 = "Surgery 2: Type/Age",
           new_mds_med_sur3 = "Surgery 3: Type/Age",
           new_mds_med_sur4 = "Surgery 4: Type/Age",
           new_mds_med_sur5 = "Surgery 5: Type/Age",
           new_mds_neu_trem_int = "Intention tremor",
           new_mds_neu_trem_rest = "Resting tremor",
           new_mds_neu_trem_pos = "Postural tremor", new_mds_neu_trem_irm = "Intermittent Tremor",
           new_mds_neu_trem_age = "Tremor age of onset", new_mds_neu_trem_head = "Head tremor",
           new_mds_neu_trem_age2 = "Head tremor age of onset", new_mds_neu_atax = "Walking/ataxia Problems",
           new_mds_neu_atax_age = "Ataxia: Age of onset",
           new_mds_ne_ga = "Ataxia",
           new_mds_ne_gas = "Ataxia severity", new_mds_med_park = "Parkinsons",
           new_mds_ne_pf = "Parkinsonian features", new_mds_ne_pfmf = "Masked facies",
           new_mds_ne_pfit = "Increased tone", new_mds_ne_pfprt = "Pill rolling tremor",
           new_mds_ne_pfsg = "Stiff gait", new_mds_fxtas_stage = "FXTAS Stage (0-5)",
           bds2_score = "BDS-2 Total Score", mmse_totalscore = "Total Score",
           scid_dxcode1 = "Interviewers Diagnosis 1, by Code", scid_dx1age = "Interviewers Diagnosis 1, Age of Onset",
           scid_dxcode2 = "Interviewers Diagnosis 2, by Code", scid_dx2age = "Interviewers Diagnosis 2, Age of Onset",
           scid_dxcode3 = "Interviewers Diagnosis 3, by Code", scid_dx3age = "Interviewers Diagnosis 3, Age of Onset",
           scl_s_som_ts = "Somatization (T-score: Nonpatient)", scl_s_oc_ts = "Obsessive-Compulsive (T-score: Nonpatient)",
           scl_s_is_ts = "Interpersonal Sensitivity T-score: Nonpatient",
           scl_s_dep_ts = "Depression(T-score: Nonpatient)", scl_s_anx_ts = "Anxiety (T-score: Nonpatient)",
           scl_s_hos_ts = "Hostility (T-score: Nonpatient)", scl_s_phob_ts = "Phobia (T-score: Nonpatient)",
           scl_s_par_ts = "Paranoid Ideation (T-score: Nonpatient)", scl_s_psy_ts = "Psychoticism (T-score: Nonpatient)",
           scl_s_gsi_ts = "Global Severity Index (T-score: Nonpatient)",
           scl_s_psdi_ts = "Positive Symptom Distress Index (T-score: Nonpatient)",
           scl_s_pst_ts = "Positive Symptom Total (T-score: Nonpatient)",
           wais4_verbcomp_cs = "Verbal Comprehension: Composite Score (VCI)",
           wais4_percorg_cs = "Perceptual Reasoning: Composite Score (PRI)",
           wais4_workmem_cs = "Working Memory: Composite Score (WMI)", wais4_procspeed_cs = "Processing Speed: Composite Score (PSI)",
           wais4_fullscale_cs = "Full Scale: Composite Score FSIQ)", cantab_ots_probsolvedfirstchoice_ = "OTS Problems solved on first choice",
           cantab_pal_toterrors_adjusted = "PAL Total errors (adjusted)",
           cantab_sst_medianrt_gotrials = "SST Median correct RT on GO trials",
           cantab_rvp_a = "RVP A", cantab_rti_5choice_movement = "RTI Five-choice movement time",
           cantab_swm_between_errors = "SWM Between errors", new_mds_med_lup = "Lupus",
           new_mds_med_ra = "Rheumatoid arthritis", new_mds_med_mswk = "Multiple Sclerosis: Workup",
           new_mds_med_ana = "ANA positive", new_mds_med_sjo = "Sjogrens Syndrome",
           new_mds_med_ray = "Raynauds Syndrome", new_mds_med_pulm = "Pulmonary Fibrosis",
           new_mds_med_immun_notes = "Immunological Notes", mri_cere_atr = "Cerebral Atrophy",
           mri_cerebel_atr = "Cerebellar Atrophy", mri_cere_wm_hyper = "Cerebral WM Hyperintensity",
           mri_cerebel_wm_hyper = "Cerebellar WM Hyperintensity", mri_mcp_wm_hyper = "MCP-WM Hyperintensity",
           mri_pons_wm_hyper = "Pons-WM Hyperintensity", mri_subins_wm_hyper = "Sub-Insular WM Hyperintensity",
           mri_peri_wm_hyper = "Periventricular WM Hyperintensity", mri_splen_wm_hyper = "Splenium (CC)-WM Hyperintensity",
           mri_genu_wm_hyper = "Genu (CC)-WM Hyperintensity", mri_corp_call_thick = "Corpus Callosum-Thickness",
           new_ds_crx1 = "Current Medications 1", new_ds_crx2 = "Current Medications 2",
           new_ds_crx3 = "Current Medications 3", new_ds_crx4 = "Current Medications 4",
           new_ds_crx5 = "Current Medications 5", new_ds_crx6 = "Current Medications 6",
           new_ds_crx7 = "Current Medications 7", new_ds_crx8 = "Current Medications 8",
           new_ds_crx9 = "Current Medications 9", new_ds_crx10 = "Current Medications 10",
           dem_date = "Visit Date",
           dem_race ="Primary Race",
           dem_eth ="Primary Ethnicity"

)

if(!isTRUE(all.equal(names(dataset), names(labels)))) browser(message('why is there a mismatch?'))

names(dataset) = labels[names(dataset)]


# labels
{
# label(data$subj_id)="FXS ID"
# label(data$redcap_event_name)="Event Name"
# label(data$sex)="Gender"
# label(data$visit_age)="Age at visit"
# label(data$mol_apoe)="ApoE"
# label(data$mol_dna_result)="Floras Non-Sortable Allele Size (CGG) Results"
# label(data$new_mds_psy_drug)="Drug use"
# label(data$new_mds_psy_drug_notes)="Drugs used"
# label(data$new_mds_psy_drug_marij)="Marijuana use"
# label(data$new_mds_psy_alco)="Alcohol abuse"
# label(data$new_mds_psy_dri)="# of drinks per day now"
# label(data$new_mds_med_thyca)="Thyroid Cancer"
# label(data$new_mds_med_skin)="Skin Cancer"
# label(data$new_mds_med_mela)="Melanoma"
# label(data$new_mds_med_proca)="Prostate Cancer"
# label(data$new_mds_med_sur1)="Surgery: Type/Age"
# label(data$new_mds_med_sur2)="Surgery 2: Type/Age"
# label(data$new_mds_med_sur3)="Surgery 3: Type/Age"
# label(data$new_mds_med_sur4)="Surgery 4: Type/Age"
# label(data$new_mds_med_sur5)="Surgery 5: Type/Age"
# label(data$new_mds_neu_trem_int)="Intention tremor"
# label(data$new_mds_neu_trem_rest)="Resting tremor"
# label(data$new_mds_neu_trem_pos)="Postural tremor"
# label(data$new_mds_neu_trem_irm)="Intermittent Tremor"
# label(data$new_mds_neu_trem_age)="Tremor age of onset"
# label(data$new_mds_neu_trem_head)="Head tremor"
# label(data$new_mds_neu_trem_age2)="Head tremor age of onset"
# label(data$new_mds_neu_atax)="Walking/ataxia Problems"
# label(data$new_mds_neu_atax_age)="Age of onset"
# label(data$new_mds_ne_ga)="Ataxia"
# label(data$new_mds_ne_gas)="Ataxia severity"
# label(data$new_mds_med_park)="Parkinsons"
# label(data$new_mds_ne_pf)="Parkinsonian features"
# label(data$new_mds_ne_pfmf)="Masked facies"
# label(data$new_mds_ne_pfit)="Increased tone"
# label(data$new_mds_ne_pfprt)="Pill rolling tremor"
# label(data$new_mds_ne_pfsg)="Stiff gait"
# label(data$new_mds_fxtas_stage)="FXTAS Stage (0-5)"
# label(data$bds2_score)="BDS-2 Total Score"
# label(data$mmse_totalscore)="Total Score"
# label(data$scid_dxcode1)="Interviewers Diagnosis 1, by Code"
# label(data$scid_dx1age)="Interviewers Diagnosis 1, Age of Onset"
# label(data$scid_dxcode2)="Interviewers Diagnosis 2, by Code"
# label(data$scid_dx2age)="Interviewers Diagnosis 2, Age of Onset"
# label(data$scid_dxcode3)="Interviewers Diagnosis 3, by Code"
# label(data$scid_dx3age)="Interviewers Diagnosis 3, Age of Onset"
# label(data$scl_s_som_ts)="Somatization (T-score: Nonpatient)"
# label(data$scl_s_oc_ts)="Obsessive-Compulsive (T-score: Nonpatient)"
# label(data$scl_s_is_ts)="Interpersonal Sensitivity T-score: Nonpatient"
# label(data$scl_s_dep_ts)="Depression(T-score: Nonpatient)"
# label(data$scl_s_anx_ts)="Anxiety (T-score: Nonpatient)"
# label(data$scl_s_hos_ts)="Hostility (T-score: Nonpatient)"
# label(data$scl_s_phob_ts)="Phobia (T-score: Nonpatient)"
# label(data$scl_s_par_ts)="Paranoid Ideation (T-score: Nonpatient)"
# label(data$scl_s_psy_ts)="Psychoticism (T-score: Nonpatient)"
# label(data$scl_s_gsi_ts)="Global Severity Index (T-score: Nonpatient)"
# label(data$scl_s_psdi_ts)="Positive Symptom Distress Index (T-score: Nonpatient)"
# label(data$scl_s_pst_ts)="Positive Symptom Total (T-score: Nonpatient)"
# label(data$wais4_verbcomp_cs)="Verbal Comprehension: Composite Score (VCI)"
# label(data$wais4_percorg_cs)="Perceptual Reasoning: Composite Score (PRI)"
# label(data$wais4_workmem_cs)="Working Memory: Composite Score (WMI)"
# label(data$wais4_procspeed_cs)="Processing Speed: Composite Score (PSI)"
# label(data$wais4_fullscale_cs)="Full Scale: Composite Score FSIQ)"
# label(data$cantab_ots_probsolvedfirstchoice_)="OTS Problems solved on first choice"
# label(data$cantab_pal_toterrors_adjusted)="PAL Total errors (adjusted)"
# label(data$cantab_sst_medianrt_gotrials)="SST Median correct RT on GO trials"
# label(data$cantab_rvp_a)="RVP A"
# label(data$cantab_rti_5choice_movement)="RTI Five-choice movement time"
# label(data$cantab_swm_between_errors)="SWM Between errors"
# label(data$new_mds_med_lup)="Lupus"
# label(data$new_mds_med_ra)="Rheumatoid arthritis"
# label(data$new_mds_med_mswk)="Multiple Sclerosis: Workup"
# label(data$new_mds_med_ana)="ANA positive"
# label(data$new_mds_med_sjo)="Sjogrens Syndrome"
# label(data$new_mds_med_ray)="Raynauds Syndrome"
# label(data$new_mds_med_pulm)="Pulmonary Fibrosis"
# label(data$new_mds_med_immun_notes)="Immunological Notes"
# label(data$mri_cere_atr)="Cerebral Atrophy"
# label(data$mri_cerebel_atr)="Cerebellar Atrophy"
# label(data$mri_cere_wm_hyper)="Cerebral WM Hyperintensity"
# label(data$mri_cerebel_wm_hyper)="Cerebellar WM Hyperintensity"
# label(data$mri_mcp_wm_hyper)="MCP-WM Hyperintensity"
# label(data$mri_pons_wm_hyper)="Pons-WM Hyperintensity"
# label(data$mri_subins_wm_hyper)="Sub-Insular WM Hyperintensity"
# label(data$mri_peri_wm_hyper)="Periventricular WM Hyperintensity"
# label(data$mri_splen_wm_hyper)="Splenium (CC)-WM Hyperintensity"
# label(data$mri_genu_wm_hyper)="Genu (CC)-WM Hyperintensity"
# label(data$mri_corp_call_thick)="Corpus Callosum-Thickness"
# label(data$new_ds_crx1)="Current Medications 1"
# label(data$new_ds_crx2)="Current Medications 2"
# label(data$new_ds_crx3)="Current Medications 3"
# label(data$new_ds_crx4)="Current Medications 4"
# label(data$new_ds_crx5)="Current Medications 5"
# label(data$new_ds_crx6)="Current Medications 6"
# label(data$new_ds_crx7)="Current Medications 7"
# label(data$new_ds_crx8)="Current Medications 8"
# label(data$new_ds_crx9)="Current Medications 9"
# label(data$new_ds_crx10)="Current Medications 10"
# label(data$dem_date)="Date of Study Enrollment - GP-4"
  # label(data$dem_race)="Primary Race"
  # label(data$dem_eth)="Primary Ethnicity"

}

#Setting Units (none)


gp4 = tibble(dataset)

use_data(gp4, overwrite = TRUE)
