#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
devtools::load_all()
library(Hmisc)
library(dplyr)
library(vroom)
library(forcats)
library(lubridate)
library(tidyr)
#Read Data
library(conflicted)
conflicts_prefer(vroom::cols)
conflicts_prefer(vroom::col_date)
conflicts_prefer(vroom::col_character)
conflicts_prefer(vroom::col_integer)
conflicts_prefer(vroom::col_double)
conflicts_prefer(vroom::col_logical)
conflicts_prefer(vroom::col_skip)

conflicted::conflict_prefer("label", "Hmisc")
conflicted::conflict_prefer("not", "magrittr")
conflicted::conflicts_prefer(dplyr::filter)

dataset=vroom::vroom(
  'inst/extdata/2023_11_07_TRAXDataforEzra.csv',
  col_types = c(
    # key: integer = "i", character = "c", double = "d", date = "D",
    #   factor = "f", logical = "l", skip = "_", guess = "?"
    study_id = "i",
    redcap_event_name = "c",
    dem_trax_subj_id = "c",
    dem_trax_date = "?",
    dem_trax_visit = "i",
    dem_trax_age = "d",
    dem_trax_gender = "i",
    dem_trax_race = "i",
    dem_trax_eth = "i",
    dem_trax_category = "i",
    dem_edlev = "i",
    dem_edyr = "d",
    kin_l_kintrem = "d",
    kin_l_kintrem = "d",
    kin_l_posttrem = "d",
    kin_l_resttrem = "d",
    kin_r_kintrem = "d",
    kin_r_posttrem = "d",
    kin_r_resttrem = "d",
    mds_crx1 = "c",
    mds_crx10 = "c",
    mds_crx2 = "c",
    mds_crx3 = "c",
    mds_crx4 = "c",
    mds_crx5 = "c",
    mds_crx6 = "c",
    mds_crx7 = "c",
    mds_crx8 = "c",
    mds_crx9 = "c",
    mds_fxtas_stage = "d",
    mds_med_ca_other = "c",
    mds_med_hyethy = "d",
    mds_med_hyothy = "d",
    mds_med_ido_notes = "c",
    mds_med_lup = "d",
    mds_med_mswk = "d",
    mds_med_proca = "d",
    mds_med_ra = "d",
    mds_med_ray = "d",
    mds_med_sjo = "d",
    mds_med_sur = "d",
    mds_med_sur_notes = "c",
    mds_med_thy = "d",
    mds_med_thyca = "d",
    mds_ne_it = "d",
    mds_ne_pfit = "d",
    mds_ne_pfmf = "d",
    mds_ne_pfprt = "d",
    mds_ne_pfsg = "d",
    mds_ne_pt = "d",
    mds_ne_rt = "d",
    mds_neu_atax = "d",
    mds_neu_atax_age = "d",
    mds_neu_atax_sev = "d",
    mds_neu_trem_age = "d",
    mds_neu_trem_irm = "d",
    mds_psy_dri = "d",
    mds_psy_drug = "d",
    mds_psy_drug_notes = "c",
    # forced to import CGG as character for range values (eg `110-130`)
    mol_cggrep01 = "c",
    mol_cggrep02 = "c",
    mri_cere_atr = "d",
    mri_cere_wm_hyper = "d",
    mri_cerebel_atr = "d",
    mri_cerebel_wm_hyper = "d",
    mri_corp_call_thick = "d",
    mri_genu_wm_hyper = "d",
    mri_mcp_wm_hyper = "d",
    mri_peri_wm_hyper = "d",
    mri_pons_wm_hyper = "d",
    mri_splen_wm_hyper = "d",
    mri_subins_wm_hyper = "d",
    new_ds_crx1 = "c",
    new_ds_crx10 = "c",
    new_ds_crx2 = "c",
    new_ds_crx3 = "c",
    new_ds_crx4 = "c",
    new_ds_crx5 = "c",
    new_ds_crx6 = "c",
    new_ds_crx7 = "c",
    new_ds_crx8 = "c",
    new_ds_crx9 = "c",
    new_mds_fxtas_stage = "d",
    new_mds_med_ana = "d",
    new_mds_med_anes1 = "d",
    new_mds_med_can_notes = "c",
    new_mds_med_can_other = "d",
    new_mds_med_hyethy = "d",
    new_mds_med_hyothy = "d",
    new_mds_med_immun_notes = "c",
    new_mds_med_lup = "d",
    new_mds_med_mela = "d",
    new_mds_med_mswk = "d",
    new_mds_med_park = "d",
    new_mds_med_proca = "d",
    new_mds_med_pulm = "d",
    new_mds_med_ra = "d",
    new_mds_med_ray = "d",
    new_mds_med_sjo = "d",
    new_mds_med_skin = "d",
    new_mds_med_sur1 = "c",
    new_mds_med_sur2 = "c",
    new_mds_med_sur3 = "c",
    new_mds_med_sur4 = "c",
    new_mds_med_sur5 = "c",
    new_mds_med_thy = "d",
    new_mds_med_thyca = "d",
    new_mds_ne_ga = "d",
    new_mds_ne_gas = "d",
    new_mds_ne_pf = "d",
    new_mds_ne_pfit = "d",
    new_mds_ne_pfmf = "d",
    new_mds_ne_pfprt = "d",
    new_mds_ne_pfsg = "d",
    new_mds_neu_atax = "d",
    new_mds_neu_atax_age = "d",
    new_mds_neu_trem_age = "d",
    new_mds_neu_trem_age2 = "d",
    new_mds_neu_trem_head = "d",
    new_mds_neu_trem_int = "d",
    new_mds_neu_trem_irm = "d",
    new_mds_neu_trem_pos = "d",
    new_mds_neu_trem_rest = "d",
    new_mds_psy_alco = "d",
    new_mds_psy_dri = "d",
    new_mds_psy_drug = "d",
    new_mds_psy_drug_marij = "d",
    new_mds_psy_drug_notes = "c",
    pp_t1rlb_total = "d",
    scid_admin = "i",
    scid_admin_reason = "_",
    scid_dx1age = "d",
    scid_dx2age = "d",
    scid_dx3age = "d",
    scid_dxcode1 = "d",
    scid_dxcode2 = "d",
    scid_dxcode3 = "d",
    scid_md01cur = "d",
    scid_md01lif = "d",
    scid_md02cur = "d",
    scid_md02lif = "d",
    scid_md03cur = "d",
    scid_md03lif = "d",
    scid_md04cur = "d",
    scid_md04lif = "d",
    scid_md07cur = "d",
    scid_md07lif = "d",
    scid_md08cur = "d",
    scid_md08lif = "d",
    scid_ps01cur = "d",
    scid_ps01lif = "d",
    scl_s_anx_ts = "d",
    scl_s_dep_ts = "d",
    scl_s_gsi_ts = "d",
    scl_s_hos_ts = "d",
    scl_s_is_ts = "d",
    scl_s_oc_ts = "d",
    scl_s_par_ts = "d",
    scl_s_phob_ts = "d",
    scl_s_psdi_ts = "d",
    scl_s_pst_ts = "d",
    scl_s_psy_ts = "d",
    scl_s_som_ts = "d",
    cantab__swm_between_errors = "d",
    cantab__sst_medianrt_gotrials = "d",
    cantab_ots_probsolvedfirstchoice_ = "d",
    cantab__rvp_a = "d",
    cantab__pal_toterrors_adjusted   = "d",
    cantab__rti_5choice_movement  = "d",
    otspsfc = "d",
    paltea28 = "d",
    rtifmdmt = "d",
    sstmrtg = "d",
    rvpa = "d",
    swmbe468 = "d",
    bds2_score = "d",
    wais_fullscale_iq = "d",
    wais_perf_iq = "d",
    wais_verb_iq = "d",
    wais_iv_fsiq = "d",
    wais_iv_perform_2 = "d",
    wais_iv_verbal = "d",
    wais_iv_perform = "d",
    wais_iv_perform_3 = "d",
    wasi_compscore_fsiq4 = "d",
    wasi_compscore_pri = "d",
    wasi_compscore_vci = "d",
    scid_fu_interviewer_diag1 = "_",
    scid_fu_interviewer_diag2 = "_",
    scid_fu_interviewer_diag3 = "_",
    scid_fu_interviewer_diag4 = "_",
    scid_fu_interviewer_diag5 = "_",
    scid_fu_interviewer_diag6 = "_",
    scid_fu_interviewer_diag7 = "_",
    scid_fu_interviewer_diag8 = "_",

    .delim = ","
  )
)


#Setting Factors(will create new variable for factors)
dataset$redcap_event_name = factor(
  dataset$redcap_event_name,
  levels=c(
    "visit_1_arm_1", "visit_2_arm_1", "visit_3_arm_1", "visit_1_arm_2",
    "visit_2_arm_2", "visit_3_arm_2", "visit_4_arm_2"
  )
)
dataset$dem_trax_gender = factor(dataset$dem_trax_gender,levels=c("0","1"))
dataset$dem_trax_race = factor(dataset$dem_trax_race,levels=c("1","2","3","4","5","6","7"))
dataset$dem_trax_eth = factor(dataset$dem_trax_eth,levels=c("1","2","3"))
dataset$dem_trax_category = factor(dataset$dem_trax_category,levels=c("0","1"))
dataset$dem_edlev = factor(dataset$dem_edlev,levels=c("1","2","3","4","5","6","7","8"))
dataset$mds_med_hyethy = factor(dataset$mds_med_hyethy,levels=c("0","1","999","888","777"))
dataset$mds_med_hyothy = factor(dataset$mds_med_hyothy,levels=c("0","1","999","888","777"))
dataset$mds_med_lup = factor(dataset$mds_med_lup,levels=c("0","1","999","777"))
dataset$mds_med_mswk = factor(dataset$mds_med_mswk,levels=c("0","1","999","777"))
dataset$mds_med_proca = factor(dataset$mds_med_proca,levels=c("0","1","999","777"))
dataset$mds_med_ra = factor(dataset$mds_med_ra,levels=c("0","1","999","777"))
dataset$mds_med_ray = factor(dataset$mds_med_ray,levels=c("0","1","999","777"))
dataset$mds_med_sjo = factor(dataset$mds_med_sjo,levels=c("0","1","999","777"))
dataset$mds_med_sur = factor(dataset$mds_med_sur,levels=c("0","1","999","777"))
dataset$mds_med_thy = factor(dataset$mds_med_thy,levels=c("0","1","999","777"))
dataset$mds_med_thyca = factor(dataset$mds_med_thyca,levels=c("0","1","999","888","777"))
dataset$mds_ne_it = factor(dataset$mds_ne_it,levels=c("0","1","999","777"))
dataset$mds_ne_pfit = factor(dataset$mds_ne_pfit,levels=c("0","1","999","777"))
dataset$mds_ne_pfmf = factor(dataset$mds_ne_pfmf,levels=c("0","1","999","777"))
dataset$mds_ne_pfprt = factor(dataset$mds_ne_pfprt,levels=c("0","1","999","777"))
dataset$mds_ne_pfsg = factor(dataset$mds_ne_pfsg,levels=c("0","1","999","777"))
dataset$mds_ne_pt = factor(dataset$mds_ne_pt,levels=c("0","1","999","777"))
dataset$mds_ne_rt = factor(dataset$mds_ne_rt,levels=c("0","1","999","888","777"))
dataset$mds_neu_atax = factor(dataset$mds_neu_atax,levels=c("0","1","999","888","777"))
dataset$mds_neu_trem_irm = factor(dataset$mds_neu_trem_irm,levels=c("0","1","999","888","777"))
dataset$mds_psy_drug = factor(dataset$mds_psy_drug,levels=c("1","2","0","999","777"))
dataset$mri_cere_atr = factor(dataset$mri_cere_atr,levels=c("0","1","3","4","999"))
dataset$mri_cere_wm_hyper = factor(dataset$mri_cere_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_cerebel_atr = factor(dataset$mri_cerebel_atr,levels=c("0","1","3","4","999"))
dataset$mri_cerebel_wm_hyper = factor(dataset$mri_cerebel_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_corp_call_thick = factor(dataset$mri_corp_call_thick,levels=c("0","1","999"))
dataset$mri_genu_wm_hyper = factor(dataset$mri_genu_wm_hyper,levels=c("0","1","999"))
dataset$mri_mcp_wm_hyper = factor(dataset$mri_mcp_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_peri_wm_hyper = factor(dataset$mri_peri_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_pons_wm_hyper = factor(dataset$mri_pons_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_splen_wm_hyper = factor(dataset$mri_splen_wm_hyper,levels=c("0","1","3","4","999"))
dataset$mri_subins_wm_hyper = factor(dataset$mri_subins_wm_hyper,levels=c("0","1","3","4","999"))
dataset$new_mds_med_ana = factor(dataset$new_mds_med_ana,levels=c("0","1","3","999","888","777"))
dataset$new_mds_med_anes1 = factor(dataset$new_mds_med_anes1,levels=c("2","3","0","999","888","777"))
dataset$new_mds_med_can_other = factor(dataset$new_mds_med_can_other,levels=c("0","1","999","888","777"))
dataset$new_mds_med_hyethy = factor(dataset$new_mds_med_hyethy,levels=c("0","1","999","888","777"))
dataset$new_mds_med_hyothy = factor(dataset$new_mds_med_hyothy,levels=c("0","1","999","888","777"))
dataset$new_mds_med_lup = factor(dataset$new_mds_med_lup,levels=c("0","1","999","888","777"))
dataset$new_mds_med_mela = factor(dataset$new_mds_med_mela,levels=c("0","1","999","888","777"))
dataset$new_mds_med_mswk = factor(dataset$new_mds_med_mswk,levels=c("0","1","999","888","777"))
dataset$new_mds_med_park = factor(dataset$new_mds_med_park,levels=c("0","1","999","888","777"))
dataset$new_mds_med_proca = factor(dataset$new_mds_med_proca,levels=c("0","1","999","888","777"))
dataset$new_mds_med_pulm = factor(dataset$new_mds_med_pulm,levels=c("0","1","999","888","777"))
dataset$new_mds_med_ra = factor(dataset$new_mds_med_ra,levels=c("0","1","999","888","777"))
dataset$new_mds_med_ray = factor(dataset$new_mds_med_ray,levels=c("0","1","999","888","777"))
dataset$new_mds_med_sjo = factor(dataset$new_mds_med_sjo,levels=c("0","1","999","888","777"))
dataset$new_mds_med_skin = factor(dataset$new_mds_med_skin,levels=c("0","1","999","888","777"))
dataset$new_mds_med_thy = factor(dataset$new_mds_med_thy,levels=c("0","1","999","888","777"))
dataset$new_mds_med_thyca = factor(dataset$new_mds_med_thyca,levels=c("0","1","999","888","777"))
dataset$new_mds_ne_ga = factor(dataset$new_mds_ne_ga,levels=c("0","1","999","777"))
dataset$new_mds_ne_pf = factor(dataset$new_mds_ne_pf,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfit = factor(dataset$new_mds_ne_pfit,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfmf = factor(dataset$new_mds_ne_pfmf,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfprt = factor(dataset$new_mds_ne_pfprt,levels=c("0","1","999","777"))
dataset$new_mds_ne_pfsg = factor(dataset$new_mds_ne_pfsg,levels=c("0","1","999","777"))
dataset$new_mds_neu_atax = factor(dataset$new_mds_neu_atax,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_head = factor(dataset$new_mds_neu_trem_head,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_int = factor(dataset$new_mds_neu_trem_int,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_irm = factor(dataset$new_mds_neu_trem_irm,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_pos = factor(dataset$new_mds_neu_trem_pos,levels=c("0","1","999","888","777"))
dataset$new_mds_neu_trem_rest = factor(dataset$new_mds_neu_trem_rest,levels=c("0","1","999","888","777"))
dataset$new_mds_psy_alco = factor(dataset$new_mds_psy_alco,levels=c("0","1","2","999","888","777"))
dataset$new_mds_psy_drug = factor(dataset$new_mds_psy_drug,levels=c("0","1","2","999","888","777"))
dataset$new_mds_psy_drug_marij = factor(dataset$new_mds_psy_drug_marij,levels=c("0","1","2","999","888","777"))
dataset$scid_admin = factor(dataset$scid_admin,levels=c("1","0"))
dataset$scid_dxcode1 = factor(dataset$scid_dxcode1,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$scid_dxcode2 = factor(dataset$scid_dxcode2,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$scid_dxcode3 = factor(dataset$scid_dxcode3,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
dataset$scid_md01cur = factor(dataset$scid_md01cur,levels=c("1","3"))
dataset$scid_md01lif = factor(dataset$scid_md01lif,levels=c("777","1","2","3"))
dataset$scid_md02cur = factor(dataset$scid_md02cur,levels=c("1","3"))
dataset$scid_md02lif = factor(dataset$scid_md02lif,levels=c("777","1","2","3"))
dataset$scid_md03cur = factor(dataset$scid_md03cur,levels=c("1","3"))
dataset$scid_md03lif = factor(dataset$scid_md03lif,levels=c("777","1","2","3"))
dataset$scid_md04cur = factor(dataset$scid_md04cur,levels=c("1","3"))
dataset$scid_md04lif = factor(dataset$scid_md04lif,levels=c("777","1","2","3"))
dataset$scid_md07cur = factor(dataset$scid_md07cur,levels=c("1","3"))
dataset$scid_md07lif = factor(dataset$scid_md07lif,levels=c("777","1","2","3"))
dataset$scid_md08cur = factor(dataset$scid_md08cur,levels=c("1","3"))
dataset$scid_md08lif = factor(dataset$scid_md08lif,levels=c("777","1","2","3"))
dataset$scid_ps01cur = factor(dataset$scid_ps01cur,levels=c("1","3"))
dataset$scid_ps01lif = factor(dataset$scid_ps01lif,levels=c("777","1","2","3"))

levels(dataset$redcap_event_name)=c("Visit 1 (Arm 1: Phase 1)","Visit 2 (Arm 1: Phase 1)","Visit 3 (Arm 1: Phase 1)","Visit 1 (Arm 2: Phase 2)","Visit 2 (Arm 2: Phase 2)","Visit 3 (Arm 2: Phase 2)","Visit 4 (Arm 2: Phase 2)")
levels(dataset$dem_trax_gender)=c("Female","Male")
levels(dataset$dem_trax_race)=c("American Indian/Alaska Native","Asian","Native Hawaiian or Other Pacific Islander","Black or African American","White","More Than One Race","Unknown / Not Reported")
levels(dataset$dem_trax_eth)=c("Hispanic or Latino","Not Hispanic or Latino","Unknown / Not Reported")
levels(dataset$dem_trax_category)=c("Control","Premutation")
levels(dataset$dem_edlev)=c("K-7","8-9","10-11","High School/GED","Partial College","BA/BS","MA/MS/PhD/MD","No Data")
levels(dataset$mds_med_hyethy)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_hyothy)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_lup)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_mswk)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_proca)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_ra)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_ray)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_sjo)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_sur)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_thy)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_med_thyca)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_it)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfit)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfmf)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfprt)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pfsg)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_pt)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_ne_rt)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_neu_atax)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_neu_trem_irm)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$mds_psy_drug)=c("Past Only","Present","None","No Response (999)","question not asked at time of data entry; check records (777)")
levels(dataset$mri_cere_atr)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_cere_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_cerebel_atr)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_cerebel_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_corp_call_thick)=c("Normal","Thin","Missing/Refused")
levels(dataset$mri_genu_wm_hyper)=c("No","Yes","Missing/Refused")
levels(dataset$mri_mcp_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_peri_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_pons_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_splen_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$mri_subins_wm_hyper)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(dataset$new_mds_med_ana)=c("No","Yes","Unknown","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_anes1)=c("Local","General","None","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_can_other)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_hyethy)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_hyothy)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_lup)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_mela)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_mswk)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_park)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_proca)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_pulm)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_ra)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_ray)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_sjo)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_skin)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_thy)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_med_thyca)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_ne_ga)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_ne_pf)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_ne_pfit)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_ne_pfmf)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_ne_pfprt)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_ne_pfsg)=c("No","Yes","No Response (999)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_neu_atax)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_neu_trem_head)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_neu_trem_int)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_neu_trem_irm)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_neu_trem_pos)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_neu_trem_rest)=c("No","Yes","No Response (999)","NA (888)","Question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_psy_alco)=c("None","Past Only","Present","No Response (999)","NA (888)","question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_psy_drug)=c("None","Past Only","Present","No Response (999)","NA (888)","question not asked at time of data entry; check records (777)")
levels(dataset$new_mds_psy_drug_marij)=c("None","Past Only","Present","No Response (999)","NA (888)","question not asked at time of data entry; check records (777)")
levels(dataset$scid_admin)=c("Yes","No")
levels(dataset$scid_dxcode1)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(dataset$scid_dxcode2)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(dataset$scid_dxcode3)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(dataset$scid_md01cur)=c("Absent","Present")
levels(dataset$scid_md01lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md02cur)=c("Absent","Present")
levels(dataset$scid_md02lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md03cur)=c("Absent","Present")
levels(dataset$scid_md03lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md04cur)=c("Absent","Present")
levels(dataset$scid_md04lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md07cur)=c("Absent","Present")
levels(dataset$scid_md07lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_md08cur)=c("Absent","Present")
levels(dataset$scid_md08lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")
levels(dataset$scid_ps01cur)=c("Absent","Present")
levels(dataset$scid_ps01lif)=c("Inadequate Info","Absent","Sub-Threshold","Threshold")


# remove mol_cggrep02 if all are missing
if(all(is.na(dataset$mol_cggrep02))){
  dataset <- dataset |>
  dplyr::select(
    -mol_cggrep02
  )
} else{
  browser(
    message(
      "Check why `mol_cggrep02` is no longer all missing"
    )
  )
}


# split data by redcap_visit_name: Arm 1 and Arm 2
data_arm1 <- dataset |>
  dplyr::filter(stringr::str_detect(redcap_event_name, "Arm 1")) |>
  # remove new_mds/new_ds variables
  dplyr::select(-c(starts_with("new_mds"), starts_with("new_ds"),
                   otspsfc, paltea28, rtifmdmt, sstmrtg, rvpa, swmbe468))

data_arm2 <- dataset |>
  dplyr::filter(stringr::str_detect(redcap_event_name, "Arm 2")) |>
  # remove mds_med variables
  dplyr::select(-c(starts_with("mds"), starts_with("cantab")))

# create labels for arm1 and arm2
labels_arm1 <- create_trax_labels(data_arm1)
labels_arm2 <- create_trax_labels(data_arm2)

# if column names and label names match -> update names with labels
if(!isTRUE(setequal(names(data_arm1), names(labels_arm1)))) browser(message('why is there a mismatch?'))
names(data_arm1) = labels_arm1[names(data_arm1)]


if(!isTRUE(setequal(names(data_arm2), names(labels_arm2)))) browser(message('why is there a mismatch?'))
names(data_arm2) = labels_arm2[names(data_arm2)]


# bind arm1 and arm2 back together
trax <- dplyr::bind_rows(
  "Trax Phase 1" = data_arm1,
  "Trax Phase 2" = data_arm2,
  .id = "Study") |>
  # clean trax data
  clean_trax_data()

# get first visit
trax_visit1 <- trax |>
  get_visit1()

usethis::use_data(trax, overwrite = TRUE)
usethis::use_data(trax_visit1, overwrite = TRUE)

library(dplyr)

trax$`FXS ID` |> intersect(gp34$`FXS ID`)

males_gp34_trax <-
  trax |>
  bind_rows(gp34) |>
  filter(Gender == "Male")

males_gp34_trax_v1 =
  males_gp34_trax |>
  get_visit1()

usethis::use_data(males_gp34_trax_v1, overwrite = TRUE)
