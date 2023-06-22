#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
library(dplyr)
library(vroom)
#Read Data
dataset=vroom::vroom(
  'inst/extdata/GPGenotypePhenotypeR-FXTASEventSequence10_DATA_2023-03-09_1125.csv',
  col_types = cols(
    dem_date = col_date(),
    mds_med_ca_other = col_character(),
    new_mds_med_can_other = col_integer(),
    new_mds_med_anes1 = col_character(),
    medic_surg_anes = col_character(),
    # dob = col_date(), # auto-removed
    subj_id = col_character(),
    redcap_event_name = col_character(),
    sex = col_double(),
    dem_race = col_character(),
    dem_eth = col_character(),
    visit_age = col_double(),
    mol_apoe = col_character(),
    mol_dna_result = col_character(),
    mds_psy_drug = col_double(),
    mds_psy_drug_notes = col_character(),
    new_mds_psy_drug_marij = col_logical(),
    mds_psy_alco = col_double(),
    mds_psy_dri = col_double(),
    mds_med_thyca = col_double(),
    new_mds_med_skin = col_logical(),
    new_mds_med_mela = col_logical(),
    mds_med_proca = col_double(),
    mds_med_sur = col_double(),
    mds_med_sur_notes = col_character(),
    new_mds_med_sur1 = col_character(),
    new_mds_med_sur2 = col_character(),
    new_mds_med_sur3 = col_character(),
    mds_ne_it = col_double(),
    mds_ne_rt = col_double(),
    mds_ne_pt = col_double(),
    mds_neu_trem_irm = col_double(),
    mds_neu_trem_age = col_double(),
    new_mds_neu_trem_head = col_logical(),
    new_mds_neu_trem_age2 = col_character(),
    mds_neu_atax = col_double(),
    mds_neu_atax_age = col_double(),
    mds_neu_atax_sev = col_character(),
    new_mds_ne_ga = col_skip(),
    new_mds_med_park = col_double(),
    mds_ne_pf = col_double(),
    mds_ne_pfmf = col_double(),
    mds_ne_pfit = col_double(),
    mds_ne_pfprt = col_double(),
    mds_ne_pfsg = col_double(),
    mds_fxtas_stage = col_double(),
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
    wais_verb_iq = col_double(),
    wais_perf_iq = col_double(),
    wais_fullscale_iq = col_double(),
    cantab_ots_probsolvedfirstchoice_ = col_double(),
    cantab_pal_toterrors_adjusted = col_double(),
    cantab_sst_medianrt_gotrials = col_double(),
    cantab_rvp_a = col_double(),
    cantab_rti_5choice_movement = col_double(),
    cantab_swm_between_errors = col_double(),
    mds_med_lup = col_double(),
    mds_med_ra = col_double(),
    mds_med_mswk = col_double(),
    new_mds_med_ana = col_logical(),
    mds_med_sjo = col_double(),
    mds_med_ray = col_double(),
    new_mds_med_pulm = col_logical(),
    mds_med_ido_notes = col_character(),
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
    ds_crx1 = col_character(),
    ds_crx2 = col_character(),
    ds_crx3 = col_character(),
    ds_crx4 = col_character(),
    ds_crx5 = col_character(),
    ds_crx6 = col_character(),
    ds_crx7 = col_character(),
    ds_crx8 = col_character(),
    ds_crx9 = col_character(),
    ds_crx10 = col_character(),

    new_mds_med_thy = col_skip(),
    new_mds_med_hyothy = col_skip(),
    new_mds_med_hyethy = col_skip(),

    .delim = ","
  )
)

#Setting Factors(will create new variable for factors)

dataset$new_mds_med_anes1 = factor(dataset$new_mds_med_anes1,levels=c("2","3","0","999","888","777"))
dataset$medic_surg_anes  = factor(dataset$medic_surg_anes,levels=c("0","1","2","3","999"))
dataset$mds_med_thy = factor(dataset$mds_med_thy,levels=c("0","1","999","888","777"))
# dataset$new_mds_med_thy = factor(dataset$new_mds_med_thy,levels=c("0","1","999","888","777"))
dataset$mds_med_hyothy = factor(dataset$mds_med_hyothy,levels=c("0","1","999","888","777"))
# dataset$new_mds_med_hyothy = factor(dataset$new_mds_med_hyothy,levels=c("0","1","999","888","777"))
dataset$mds_med_hyethy = factor(dataset$mds_med_hyethy,levels=c("0","1","999","888","777"))
# dataset$new_mds_med_hyethy = factor(dataset$new_mds_med_hyethy,levels=c("0","1","999","888","777"))

dataset$new_mds_med_can_other = factor(dataset$new_mds_med_can_other,levels=c("0","1","999","888","777"))

dataset$redcap_event_name = factor(dataset$redcap_event_name,levels=c("gp1_visit_1_arm_1","gp1_visit_2_arm_1","gp1_visit_3_arm_1","gp2_visit_1_arm_1","gp2_visit_2_arm_1","gp2__visit_3_arm_1","gp3__visit_1_arm_1","gp3__visit_2_arm_1","gp3__visit_3_arm_1","gp3__visit_4_arm_1","gp4_arm_1"))
dataset$sex = factor(dataset$sex,levels=c("0","1"))
dataset$mds_psy_drug = factor(dataset$mds_psy_drug,levels=c("1","2","0","999","888","777"))
dataset$new_mds_psy_drug_marij = factor(dataset$new_mds_psy_drug_marij,levels=c("0","1","2","999","888","777"))
dataset$mds_psy_alco = factor(dataset$mds_psy_alco,levels=c("1","2","0","999","888","777"))
dataset$mds_med_thyca = factor(dataset$mds_med_thyca,levels=c("0","1","999","888","777"))
dataset$new_mds_med_skin = factor(dataset$new_mds_med_skin,levels=c("0","1","999","888","777"))
dataset$new_mds_med_mela = factor(dataset$new_mds_med_mela,levels=c("0","1","999","888","777"))
dataset$mds_med_proca = factor(dataset$mds_med_proca,levels=c("0","1","999","888","777"))
dataset$mds_med_sur = factor(dataset$mds_med_sur,levels=c("0","1","999","888","777"))
dataset$mds_ne_it = factor(dataset$mds_ne_it,levels=c("0","1","999","777"))
dataset$mds_ne_rt = factor(dataset$mds_ne_rt,levels=c("0","1","999","888","777"))
dataset$mds_ne_pt = factor(dataset$mds_ne_pt,levels=c("0","1","999","777"))
dataset$mds_neu_trem_irm = factor(dataset$mds_neu_trem_irm,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_head = factor(dataset$new_mds_neu_trem_head,levels=c("0","1","999","888","777"))
dataset$mds_neu_atax = factor(dataset$mds_neu_atax,levels=c("0","1","999","888","777"))
# dataset$new_mds_ne_ga = factor(dataset$new_mds_ne_ga,levels=c("0","1","999","777"))
dataset$new_mds_med_park = factor(dataset$new_mds_med_park,levels=c("0","1","999","888","777"))
dataset$mds_ne_pf = factor(dataset$mds_ne_pf,levels=c("0","1","999","777"))
dataset$mds_ne_pfmf = factor(dataset$mds_ne_pfmf,levels=c("0","1","999","777"))
dataset$mds_ne_pfit = factor(dataset$mds_ne_pfit,levels=c("0","1","999","777"))
dataset$mds_ne_pfprt = factor(dataset$mds_ne_pfprt,levels=c("0","1","999","777"))
dataset$mds_ne_pfsg = factor(dataset$mds_ne_pfsg,levels=c("0","1","999","777"))
dataset$scid_dxcode1 = factor(dataset$scid_dxcode1,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$scid_dxcode2 = factor(dataset$scid_dxcode2,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$scid_dxcode3 = factor(dataset$scid_dxcode3,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$mds_med_lup = factor(dataset$mds_med_lup,levels=c("0","1","999","888","777"))
dataset$mds_med_ra = factor(dataset$mds_med_ra,levels=c("0","1","999","888","777"))
dataset$mds_med_mswk = factor(dataset$mds_med_mswk,levels=c("0","1","999","888","777"))
dataset$new_mds_med_ana = factor(dataset$new_mds_med_ana,levels=c("0","1","3","999","888","777"))
dataset$mds_med_sjo = factor(dataset$mds_med_sjo,levels=c("0","1","999","888","777"))
dataset$mds_med_ray = factor(dataset$mds_med_ray,levels=c("0","1","999","888","777"))
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
# dataset$mds_psy_dri = factor(dataset$mds_psy_dri)
dataset$dem_race = factor(dataset$dem_race,levels=c("1","2","3","4","5","8","6","7"))
dataset$dem_eth = factor(dataset$dem_eth,levels=c("1","2","3"))

dataset$mds_med_thy = factor(dataset$mds_med_thy,levels=c("0","1","999","888","777"))
# dataset$new_mds_med_thy = factor(dataset$new_mds_med_thy,levels=c("0","1","999","888","777"))
dataset$mds_med_hyothy = factor(dataset$mds_med_hyothy,levels=c("0","1","999","888","777"))
# dataset$new_mds_med_hyothy = factor(dataset$new_mds_med_hyothy,levels=c("0","1","999","888","777"))
dataset$mds_med_hyethy = factor(dataset$mds_med_hyethy,levels=c("0","1","999","888","777"))
# dataset$new_mds_med_hyethy = factor(dataset$new_mds_med_hyethy,levels=c("0","1","999","888","777"))
dataset$scid_admin = factor(dataset$scid_admin,levels=c("0","1","2","888"))
dataset$scid_md01lif = factor(dataset$scid_md01lif,levels=c("777","1","2","3"))
dataset$scid_md01cur = factor(dataset$scid_md01cur,levels=c("1","3","777"))
dataset$scid_md02lif = factor(dataset$scid_md02lif,levels=c("777","1","2","3"))
dataset$scid_md02cur = factor(dataset$scid_md02cur,levels=c("1","3","777"))
dataset$scid_md03cur = factor(dataset$scid_md03cur,levels=c("1","3","777"))
dataset$scid_md03lif = factor(dataset$scid_md03lif,levels=c("777","1","2","3"))
dataset$scid_md04cur = factor(dataset$scid_md04cur,levels=c("1","3","777"))
dataset$scid_md04lif = factor(dataset$scid_md04lif,levels=c("777","1","2","3"))
dataset$scid_md07cur = factor(dataset$scid_md07cur,levels=c("1","3","777"))
dataset$scid_md07lif = factor(dataset$scid_md07lif,levels=c("777","1","3"))
dataset$scid_md08cur = factor(dataset$scid_md08cur,levels=c("1","3","777"))
dataset$scid_md08lif = factor(dataset$scid_md08lif,levels=c("777","1","3"))
dataset$scid_ps01cur = factor(dataset$scid_ps01cur,levels=c("1","3","777"))
dataset$scid_ps01lif = factor(dataset$scid_ps01lif,levels=c("777","1","2","3"))


levels(dataset$scid_admin)=c("No","Yes","Follow up","N/A")
levels(dataset$new_mds_med_anes1)=c("Local","General","None","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$medic_surg_anes)=c("None","Local","General","Other","Missing/Refused (999)")
levels(dataset$mds_med_thy)=c("No","Yes","No Response (999)","NA","Question not asked at time of data entry; check records")
# levels(dataset$new_mds_med_thy)=c("No","Yes","No Response (999)","NA","Question not asked at time of data entry; check records")
levels(dataset$mds_med_hyothy)=c("No","Yes","No Response (999)","NA","Question not asked at time of data entry; check records")
# levels(dataset$new_mds_med_hyothy)=c("No","Yes","No Response (999)","NA","Question not asked at time of data entry; check records")
levels(dataset$mds_med_hyethy)=c("No","Yes","No Response (999)","NA","Question not asked at time of data entry; check records")
# levels(dataset$new_mds_med_hyethy)=c("No","Yes","No Response (999)","NA","Question not asked at time of data entry; check records")

levels(dataset$scid_admin)=c("No","Yes","Follow up","N/A")
levels(dataset$scid_md01lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md01cur)=c("Absent","Present","Inadequate Info")
levels(dataset$scid_md02lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md02cur)=c("Absent","Present","Inadequate Info")
levels(dataset$scid_md03cur)=c("Absent","Present","Inadequate Info")
levels(dataset$scid_md03lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md04cur)=c("Absent","Present","Inadequate Info")
levels(dataset$scid_md04lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md07cur)=c("Absent","Present","Inadequate Info")
levels(dataset$scid_md07lif)=c("Inadequate Info","Absent","Threshold")
levels(dataset$scid_md08cur)=c("Absent","Present","Inadequate Info")
levels(dataset$scid_md08lif)=c("Inadequate Info","Absent","Threshold")
levels(dataset$scid_ps01cur)=c("Absent","Present","Inadequate Info")
levels(dataset$scid_ps01lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")


levels(dataset$new_mds_med_can_other)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")


levels(dataset$dem_race)=c("American Indian/Alaska Native","Asian","Black or African American","Native Hawaiian or Other Pacific Islander","White","Australian Aborigine","More Than One Race","Unknown / Not Reported")

levels(dataset$dem_eth)=c("Hispanic or Latino","NOT Hispanic or Latino","Unknown / Not Reported")

levels(dataset$redcap_event_name)=c("GP1- Visit 1","GP1- Visit 2","GP1- Visit 3","GP2- Visit 1","GP2- Visit 2","GP2 - Visit 3","GP3 - Visit 1","GP3 - Visit 2","GP3 - Visit 3","GP3 - Visit 4","GP4")
levels(dataset$sex)=c("Female","Male")
levels(dataset$mds_psy_drug)=c("Past Only","Present","None","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_psy_drug_marij)=c("None","Past Only","Present","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_psy_alco)=c("Past Only","Present","None","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_thyca)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_skin)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_mela)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_proca)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_sur)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_it)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_rt)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pt)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_neu_trem_irm)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_neu_trem_head)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_neu_atax)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
# levels(dataset$new_mds_ne_ga)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_park)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pf)=c("Yes","No","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfmf)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfit)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfprt)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfsg)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$scid_dxcode1)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed (777)","Not Applicable (888)","None Listed or Incomplete Data (999)")
levels(dataset$scid_dxcode2)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed (777)","Not Applicable (888)","None Listed or Incomplete Data (999)")
levels(dataset$scid_dxcode3)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed (777)","Not Applicable (888)","None Listed or Incomplete Data (999)")
levels(dataset$mds_med_lup)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_ra)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_mswk)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_ana)=c("No","Yes","Unknown","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_sjo)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_ray)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_pulm)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mri_cere_atr)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_cerebel_atr)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_cere_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_cerebel_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_mcp_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_pons_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_subins_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_peri_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_splen_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused (999)")
levels(dataset$mri_genu_wm_hyper)=c("No","Yes","Missing/Refused (999)")
levels(dataset$mri_corp_call_thick)=c("Normal","Thin","Missing/Refused (999)")

#Setting Labels
# browser()

labels = c(subj_id = "FXS ID", redcap_event_name = "Event Name", visit_age = "Age at visit",
           mds_med_ca_other="Other Cancer (detailed)",
           new_mds_med_can_other="Other Cancer",

           new_mds_med_anes1="Anesthesia (new_mds_med_anes1)",
           medic_surg_anes="Anesthesia (medic_surg_anes)",
           pp_t1rlb_total ="1st Trial Total, R+L+B",
           mds_med_thy ="Thyroid problems",
           # new_mds_med_thy ="Thyroid problems",
           mds_med_hyothy ="Hypothyroid",
           # new_mds_med_hyothy ="Hypothyroid",
           mds_med_hyethy ="Hyperthyroid",
           # new_mds_med_hyethy ="Hyperthyroid",

           sex = "Gender",
           mol_apoe = "ApoE",
           mol_dna_result = "Floras Non-Sortable Allele Size (CGG) Results",
           mds_psy_drug = "Drug use",
           mds_psy_drug_notes = "Drugs used",
           new_mds_psy_drug_marij = "Marijuana use",
           mds_psy_alco = "Alcohol use/abuse",
           mds_psy_dri = "# of drinks per day now",
           mds_med_thyca = "Thyroid Cancer",
           new_mds_med_skin = "Skin Cancer",
           new_mds_med_mela = "Melanoma",
           mds_med_proca = "Prostate Cancer",
           mds_med_sur = "Surgery",
           mds_med_sur_notes = "Surgery type",
           new_mds_med_sur1 = "Surgery: Type/Age",
           new_mds_med_sur2 = "Surgery 2: Type/Age",
           new_mds_med_sur3 = "Surgery 3: Type/Age",
           mds_ne_it = "Intention tremor",
           mds_ne_rt = "Resting tremor",
           mds_ne_pt = "Postural tremor",
           mds_neu_trem_irm = "Intermittent tremor",
           mds_neu_trem_age = "Tremor: Age of onset",
           new_mds_neu_trem_head = "Head tremor",
           new_mds_neu_trem_age2 = "Head Tremor: Age of onset",
           mds_neu_atax = "Ataxia",
           mds_neu_atax_age = "Ataxia: Age of onset",
           mds_neu_atax_sev = "Ataxia: severity",
           # new_mds_ne_ga = "Ataxia",
           new_mds_med_park = "Parkinsons",
           mds_ne_pf = "Parkinsonian features",
           mds_ne_pfmf = "Parkinsonian features: Masked faces",
           mds_ne_pfit = "Parkinsonian features: Increased tone",
           mds_ne_pfprt = "Parkinsonian features: Pill rolling tremor",
           mds_ne_pfsg = "Parkinsonian features: Stiff gait",
           mds_fxtas_stage = "FXTAS Stage (0-5)",
           bds2_score = "BDS-2 Total Score",
           mmse_totalscore = "MMSE Total Score",
           scid_dxcode1 = "Interviewers Diagnosis 1,  by Code",
           scid_dx1age = "Interviewers Diagnosis 1, Age of Onset",
           scid_dxcode2 = "Interviewers Diagnosis 2,  by Code",
           scid_dx2age = "Interviewers Diagnosis 2, Age of Onset",
           scid_dxcode3 = "Interviewers Diagnosis 3,  by Code",
           scid_dx3age = "Interviewers Diagnosis 3, Age of Onset",
           scl_s_som_ts = "SCL90: Somatization",
           scl_s_oc_ts = "SCL90: Obsessive-Compulsive",
           scl_s_is_ts = "SCL90: Interpersonal Sensitivity",
           scl_s_dep_ts = "SCL90: Depression",
           scl_s_anx_ts = "SCL90: Anxiety",
           scl_s_hos_ts = "SCL90: Hostility",
           scl_s_phob_ts = "SCL90: Phobia",
           scl_s_par_ts = "SCL90: Paranoid Ideation",
           scl_s_psy_ts = "SCL90: Psychoticism",
           scl_s_gsi_ts = "SCL90: Global Severity Index",
           scl_s_psdi_ts = "SCL90: Positive Symptom Distress Index",
           scl_s_pst_ts = "SCL90: Positive Symptom Total",

           wais_verb_iq = "Verbal: IQ Score",
           wais_perf_iq = "Performance: IQ Score",
           wais_fullscale_iq = "Full Scale: IQ Score",

           cantab_ots_probsolvedfirstchoice_ = "OTS Problems solved on first choice",
           cantab_pal_toterrors_adjusted = "PAL Total errors (adjusted)",
           cantab_sst_medianrt_gotrials = "SST Median correct RT on GO trials",
           cantab_rvp_a = "RVP A signal detection",
           cantab_rti_5choice_movement = "RTI Five-choice movement time",
           cantab_swm_between_errors = "SWM Between errors",

           mds_med_lup = "Lupus",
           mds_med_ra = "Rheumatoid arthritis",
           mds_med_mswk = "Multiple Sclerosis: Workup",
           new_mds_med_ana = "ANA positive",
           mds_med_sjo = "Sjogrens Syndrome",
           mds_med_ray = "Raynauds disease",
           new_mds_med_pulm = "Pulmonary Fibrosis",
           mds_med_ido_notes = "Other immunological disease & other symptoms: list",

           mri_cere_atr = "Cerebral Atrophy",
           mri_cerebel_atr = "Cerebellar Atrophy",
           mri_cere_wm_hyper = "Cerebral WM Hyperintensity", mri_cerebel_wm_hyper = "Cerebellar WM Hyperintensity",
           mri_mcp_wm_hyper = "MCP-WM Hyperintensity", mri_pons_wm_hyper = "Pons-WM Hyperintensity",
           mri_subins_wm_hyper = "Sub-Insular WM Hyperintensity", mri_peri_wm_hyper = "Periventricular WM Hyperintensity",
           mri_splen_wm_hyper = "Splenium (CC)-WM Hyperintensity", mri_genu_wm_hyper = "Genu (CC)-WM Hyperintensity",
           mri_corp_call_thick = "Corpus Callosum-Thickness", ds_crx1 = "Current Medications 1",
           ds_crx2 = "Current Medications 2", ds_crx3 = "Current Medications 3",
           ds_crx4 = "Current Medications 4", ds_crx5 = "Current Medications 5",
           ds_crx6 = "Current Medications 6", ds_crx7 = "Current Medications 7",
           ds_crx8 = "Current Medications 8", ds_crx9 = "Current Medications 9",
           ds_crx10 = "Current Medications 10",
           dem_race="Primary Race",
           dem_eth="Primary Ethnicity",
           dem_date="Visit Date",

           pp_t1rlb_total = "1st Trial Total, R+L+B",
           mds_med_thy = "Thyroid problems",
           # new_mds_med_thy = "Thyroid problems",
           mds_med_hyothy = "Hypothyroid",
           # new_mds_med_hyothy = "Hypothyroid",
           mds_med_hyethy = "Hyperthyroid",
           # new_mds_med_hyethy = "Hyperthyroid",
           scid_admin = "Was SCID completed?",
           scid_reason = "If No, please comment:",
           scid_md01lif = "Bipolar I Disorder (MD01), Lifetime",
           scid_md01cur = "Bipolar I Disorder (MD01), Current",
           scid_md02lif = "Bipolar II Disorder (MD02), Lifetime",
           scid_md02cur = "Bipolar II Disorder (MD02), Current",
           scid_md03cur = "Other Bipolar Disorder (MD03), Current",
           scid_md03lif = "Other Bipolar Disorder (MD03), Lifetime",
           scid_md04cur = "Major Depressive Disorder (MD04), Current",
           scid_md04lif = "Major Depressive Disorder (MD04), Lifetime",
           scid_md07cur = "Mood Disorder Due to a GMC (MD07), Current",
           scid_md07lif = "Mood Disorder Due to GMC (MD07), Lifetime",
           scid_md08cur = "Substance-Induced Mood Dis. (MD08), Current",
           scid_md08lif = "Substance-Induced Mood Dis. (MD08), Lifetime",
           scid_ps01cur = "Primary Psychotic Symptoms (PS01), Current",
           scid_ps01lif = "Primary Psychotic Symptoms (PS01), Lifetime")

if(!isTRUE(setequal(names(dataset), names(labels)))) browser(message('why is there a mismatch?'))

names(dataset) = labels[names(dataset)]

#labels
if(FALSE)
{
  # label(dataset$subj_id)="FXS ID"
  # label(dataset$redcap_event_name)="Event Name"
  # label(dataset$visit_age)="Age at visit"
  # label(dataset$sex)="Gender"
  # label(dataset$mol_apoe)="ApoE"
  # label(dataset$mol_dna_result)="Floras Non-Sortable Allele Size (CGG) Results"
  # label(dataset$mds_psy_drug)="Drug use"
  # label(dataset$mds_psy_drug_notes)="Drugs used"
  # label(dataset$new_mds_psy_drug_marij)="Marijuana use"
  # label(dataset$mds_psy_alco)="Alcohol use"
  # label(dataset$mds_psy_dri)="# of drinks per day now"
  # label(dataset$mds_med_thyca)="Thyroid Cancer"
  # label(dataset$new_mds_med_skin)="Skin Cancer"
  # label(dataset$new_mds_med_mela)="Melanoma"
  # label(dataset$mds_med_proca)="Prostate Cancer"
  # label(dataset$mds_med_sur)="Surgery"
  # label(dataset$mds_med_sur_notes)="Surgery type"
  # label(dataset$new_mds_med_sur1)="Surgery: Type/Age"
  # label(dataset$new_mds_med_sur2)="Surgery 2: Type/Age"
  # label(dataset$new_mds_med_sur3)="Surgery 3: Type/Age"
  # label(dataset$mds_ne_it)="Intention tremor"
  # label(dataset$mds_ne_rt)="Resting tremor"
  # label(dataset$mds_ne_pt)="Postural tremor"
  # label(dataset$mds_neu_trem_irm)="Intermittent tremor"
  # label(dataset$mds_neu_trem_age)="Tremor: Age of onset"
  # label(dataset$new_mds_neu_trem_head)="Head tremor"
  # label(dataset$new_mds_neu_trem_age2)="Head Tremor: Age of onset"
  # label(dataset$mds_neu_atax)="Problem with walking/ataxia"
  # label(dataset$mds_neu_atax_age)="Ataxia: Age of onset"
  # label(dataset$mds_neu_atax_sev)="Ataxia: severity"
  # label(dataset$new_mds_ne_ga)="Ataxia"
  # label(dataset$new_mds_med_park)="Parkinsons"
  # label(dataset$mds_ne_pf)="Parkinsonian features:"
  # label(dataset$mds_ne_pfmf)="Parkinsonian features: Masked faces"
  # label(dataset$mds_ne_pfit)="Parkinsonian features: Increased tone"
  # label(dataset$mds_ne_pfprt)="Parkinsonian features: pill rolling tremor"
  # label(dataset$mds_ne_pfsg)="Parkinsonian features: stiff gait"
  # label(dataset$mds_fxtas_stage)="FXTAS Stage (0-5)"
  # label(dataset$bds2_score)="BDS-2 Total Score"
  # label(dataset$mmse_totalscore)="Total Score"
  # label(dataset$scid_dxcode1)="Interviewers Diagnosis 1,  by Code"
  # label(dataset$scid_dx1age)="Interviewers Diagnosis 1, Age of Onset"
  # label(dataset$scid_dxcode2)="Interviewers Diagnosis 2,  by Code"
  # label(dataset$scid_dx2age)="Interviewers Diagnosis 2, Age of Onset"
  # label(dataset$scid_dxcode3)="Interviewers Diagnosis 3,  by Code"
  # label(dataset$scid_dx3age)="Interviewers Diagnosis 3, Age of Onset"
  # label(dataset$scl_s_som_ts)="SCL90: Somatization"
  # label(dataset$scl_s_oc_ts)="SCL90: Obsessive-Compulsive"
  # label(dataset$scl_s_is_ts)="SCL90: Interpersonal Sensitivity"
  # label(dataset$scl_s_dep_ts)="SCL90: Depression"
  # label(dataset$scl_s_anx_ts)="SCL90: Anxiety"
  # label(dataset$scl_s_hos_ts)="SCL90: Hostility"
  # label(dataset$scl_s_phob_ts)="SCL90: Phobia"
  # label(dataset$scl_s_par_ts)="SCL90: Paranoid Ideation"
  # label(dataset$scl_s_psy_ts)="SCL90: Psychoticism"
  # label(dataset$scl_s_gsi_ts)="SCL90: Global Severity Index"
  # label(dataset$scl_s_psdi_ts)="SCL90: Positive Symptom Distress Index"
  # label(dataset$scl_s_pst_ts)="SCL90: Positive Symptom Total"
  # label(dataset$wais_verb_iq)="Verbal: IQ Score"
  # label(dataset$wais_perf_iq)="Performance: IQ Score"
  # label(dataset$wais_fullscale_iq)="Full Scale: IQ Score"
  # label(dataset$cantab_ots_probsolvedfirstchoice_)="OTS Problems solved on first choice"
  # label(dataset$cantab_pal_toterrors_adjusted)="PAL Total errors (adjusted)"
  # label(dataset$cantab_sst_medianrt_gotrials)="SST Median correct RT on GO trials"
  # label(dataset$cantab_rvp_a)="RVP A signal detection"
  # label(dataset$cantab_rti_5choice_movement)="RTI Five-choice movement time"
  # label(dataset$cantab_swm_between_errors)="SWM Between errors"
  # label(dataset$mds_med_lup)="Lupus"
  # label(dataset$mds_med_ra)="Rheumatoid arthritis"
  # label(dataset$mds_med_mswk)="Multiple Sclerosis: Workup"
  # label(dataset$new_mds_med_ana)="ANA positive"
  # label(dataset$mds_med_sjo)="Sjogrens Syndrome"
  # label(dataset$mds_med_ray)="Raynauds disease"
  # label(dataset$new_mds_med_pulm)="Pulmonary Fibrosis"
  # label(dataset$mds_med_ido_notes)="Other immunological disease & other symptoms: list"
  # label(dataset$mri_cere_atr)="Cerebral Atrophy"
  # label(dataset$mri_cerebel_atr)="Cerebellar Atrophy"
  # label(dataset$mri_cere_wm_hyper)="Cerebral WM Hyperintensity"
  # label(dataset$mri_cerebel_wm_hyper)="Cerebellar WM Hyperintensity"
  # label(dataset$mri_mcp_wm_hyper)="MCP-WM Hyperintensity"
  # label(dataset$mri_pons_wm_hyper)="Pons-WM Hyperintensity"
  # label(dataset$mri_subins_wm_hyper)="Sub-Insular WM Hyperintensity"
  # label(dataset$mri_peri_wm_hyper)="Periventricular WM Hyperintensity"
  # label(dataset$mri_splen_wm_hyper)="Splenium (CC)-WM Hyperintensity"
  # label(dataset$mri_genu_wm_hyper)="Genu (CC)-WM Hyperintensity"
  # label(dataset$mri_corp_call_thick)="Corpus Callosum-Thickness"
  # label(dataset$ds_crx1)="Current Medications 1"
  # label(dataset$ds_crx2)="Current Medications 2"
  # label(dataset$ds_crx3)="Current Medications 3"
  # label(dataset$ds_crx4)="Current Medications 4"
  # label(dataset$ds_crx5)="Current Medications 5"
  # label(dataset$ds_crx6)="Current Medications 6"
  # label(dataset$ds_crx7)="Current Medications 7"
  # label(dataset$ds_crx8)="Current Medications 8"
  # label(dataset$ds_crx9)="Current Medications 9"
  # label(dataset$ds_crx10)="Current Medications 10"
  # label(dataset$dem_race)="Primary Race"
  # label(dataset$dem_eth)="Primary Ethnicity"
  # label(dataset$dem_date)="Visit Date"
}
#Setting Units

gp3 = tibble(dataset)
usethis::use_data(gp3, overwrite = TRUE)
