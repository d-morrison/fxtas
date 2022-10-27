#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('CTSC3704GP4GenotypeP-FXTASEventSequence10_DATA_2022-10-27_0848.csv')
#Setting Labels

label(data$subj_id)="Subject ID (FXS ID)"
label(data$redcap_event_name)="Event Name"
label(data$sex)="Gender"
label(data$visit_age)="Age at visit"
label(data$mol_apoe)="ApoE"
label(data$mol_dna_result)="Floras Non-Sortable Allele Size (CGG) Results"
label(data$new_mds_psy_drug)="Drug use"
label(data$new_mds_psy_drug_notes)="Drugs used"
label(data$new_mds_psy_drug_marij)="Marijuana use"
label(data$new_mds_psy_alco)="Alcohol abuse"
label(data$new_mds_psy_dri)="# of drinks per day now"
label(data$new_mds_med_thyca)="Thyroid Cancer"
label(data$new_mds_med_skin)="Skin Cancer"
label(data$new_mds_med_mela)="Melanoma"
label(data$new_mds_med_proca)="Prostate Cancer"
label(data$new_mds_med_sur1)="Surgery: Type/Age"
label(data$new_mds_med_sur2)="Surgery 2: Type/Age"
label(data$new_mds_med_sur3)="Surgery 3: Type/Age"
label(data$new_mds_med_sur4)="Surgery 4: Type/Age"
label(data$new_mds_med_sur5)="Surgery 5: Type/Age"
label(data$new_mds_neu_trem_int)="Intention tremor"
label(data$new_mds_neu_trem_rest)="Resting tremor"
label(data$new_mds_neu_trem_pos)="Postural tremor"
label(data$new_mds_neu_trem_irm)="Intermittent Tremor"
label(data$new_mds_neu_trem_age)="Tremor age of onset"
label(data$new_mds_neu_trem_head)="Head tremor"
label(data$new_mds_neu_trem_age2)="Head tremor age of onset"
label(data$new_mds_neu_atax)="Walking/ataxia Problems"
label(data$new_mds_neu_atax_age)="Age of onset"
label(data$new_mds_ne_ga)="Ataxia"
label(data$new_mds_ne_gas)="Ataxia severity"
label(data$new_mds_med_park)="Parkinsons"
label(data$new_mds_ne_pf)="Parkinsonian features"
label(data$new_mds_ne_pfmf)="Masked facies"
label(data$new_mds_ne_pfit)="Increased tone"
label(data$new_mds_ne_pfprt)="Pill rolling tremor"
label(data$new_mds_ne_pfsg)="Stiff gait"
label(data$new_mds_fxtas_stage)="FXTAS Stage (0-5)"
label(data$bds2_score)="BDS-2 Total Score"
label(data$mmse_totalscore)="Total Score"
label(data$scid_dxcode1)="Interviewers Diagnosis 1, by Code"
label(data$scid_dx1age)="Interviewers Diagnosis 1, Age of Onset"
label(data$scid_dxcode2)="Interviewers Diagnosis 2, by Code"
label(data$scid_dx2age)="Interviewers Diagnosis 2, Age of Onset"
label(data$scid_dxcode3)="Interviewers Diagnosis 3, by Code"
label(data$scid_dx3age)="Interviewers Diagnosis 3, Age of Onset"
label(data$scl_s_som_ts)="Somatization (T-score: Nonpatient)"
label(data$scl_s_oc_ts)="Obsessive-Compulsive (T-score: Nonpatient)"
label(data$scl_s_is_ts)="Interpersonal Sensitivity T-score: Nonpatient"
label(data$scl_s_dep_ts)="Depression(T-score: Nonpatient)"
label(data$scl_s_anx_ts)="Anxiety (T-score: Nonpatient)"
label(data$scl_s_hos_ts)="Hostility (T-score: Nonpatient)"
label(data$scl_s_phob_ts)="Phobia (T-score: Nonpatient)"
label(data$scl_s_par_ts)="Paranoid Ideation (T-score: Nonpatient)"
label(data$scl_s_psy_ts)="Psychoticism (T-score: Nonpatient)"
label(data$scl_s_gsi_ts)="Global Severity Index (T-score: Nonpatient)"
label(data$scl_s_psdi_ts)="Positive Symptom Distress Index (T-score: Nonpatient)"
label(data$scl_s_pst_ts)="Positive Symptom Total (T-score: Nonpatient)"
label(data$wais4_verbcomp_cs)="Verbal Comprehension: Composite Score (VCI)"
label(data$wais4_percorg_cs)="Perceptual Reasoning: Composite Score (PRI)"
label(data$wais4_workmem_cs)="Working Memory: Composite Score (WMI)"
label(data$wais4_procspeed_cs)="Processing Speed: Composite Score (PSI)"
label(data$wais4_fullscale_cs)="Full Scale: Composite Score FSIQ)"
label(data$cantab_ots_probsolvedfirstchoice_)="OTS Problems solved on first choice"
label(data$cantab_pal_toterrors_adjusted)="PAL Total errors (adjusted)"
label(data$cantab_sst_medianrt_gotrials)="SST Median correct RT on GO trials"
label(data$cantab_rvp_a)="RVP A"
label(data$cantab_rti_5choice_movement)="RTI Five-choice movement time"
label(data$cantab_swm_between_errors)="SWM Between errors"
label(data$new_mds_med_lup)="Lupus"
label(data$new_mds_med_ra)="Rheumatoid arthritis"
label(data$new_mds_med_mswk)="Multiple Sclerosis: Workup"
label(data$new_mds_med_ana)="ANA positive"
label(data$new_mds_med_sjo)="Sjogrens Syndrome"
label(data$new_mds_med_ray)="Raynauds Syndrome"
label(data$new_mds_med_pulm)="Pulmonary Fibrosis"
label(data$new_mds_med_immun_notes)="Immunological Notes"
label(data$mri_cere_atr)="Cerebral Atrophy"
label(data$mri_cerebel_atr)="Cerebellar Atrophy"
label(data$mri_cere_wm_hyper)="Cerebral WM Hyperintensity"
label(data$mri_cerebel_wm_hyper)="Cerebellar WM Hyperintensity"
label(data$mri_mcp_wm_hyper)="MCP-WM Hyperintensity"
label(data$mri_pons_wm_hyper)="Pons-WM Hyperintensity"
label(data$mri_subins_wm_hyper)="Sub-Insular WM Hyperintensity"
label(data$mri_peri_wm_hyper)="Periventricular WM Hyperintensity"
label(data$mri_splen_wm_hyper)="Splenium (CC)-WM Hyperintensity"
label(data$mri_genu_wm_hyper)="Genu (CC)-WM Hyperintensity"
label(data$mri_corp_call_thick)="Corpus Callosum-Thickness"
label(data$new_ds_crx1)="Current Medications 1"
label(data$new_ds_crx2)="Current Medications 2"
label(data$new_ds_crx3)="Current Medications 3"
label(data$new_ds_crx4)="Current Medications 4"
label(data$new_ds_crx5)="Current Medications 5"
label(data$new_ds_crx6)="Current Medications 6"
label(data$new_ds_crx7)="Current Medications 7"
label(data$new_ds_crx8)="Current Medications 8"
label(data$new_ds_crx9)="Current Medications 9"
label(data$new_ds_crx10)="Current Medications 10"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("gp4__visit_1_arm_1","gp4__visit_2_arm_1","gp4__visit_3_arm_1","gp4__visit_4_arm_1","gp4__single_visit_arm_1","gp4__participant_s_arm_1"))
data$sex.factor = factor(data$sex,levels=c("0","1"))
data$new_mds_psy_drug.factor = factor(data$new_mds_psy_drug,levels=c("0","1","2","999","888","777"))
data$new_mds_psy_drug_marij.factor = factor(data$new_mds_psy_drug_marij,levels=c("0","1","2","999","888","777"))
data$new_mds_psy_alco.factor = factor(data$new_mds_psy_alco,levels=c("0","1","2","999","888","777"))
data$new_mds_med_thyca.factor = factor(data$new_mds_med_thyca,levels=c("0","1","999","888","777"))
data$new_mds_med_skin.factor = factor(data$new_mds_med_skin,levels=c("0","1","999","888","777"))
data$new_mds_med_mela.factor = factor(data$new_mds_med_mela,levels=c("0","1","999","888","777"))
data$new_mds_med_proca.factor = factor(data$new_mds_med_proca,levels=c("0","1","999","888","777"))
data$new_mds_neu_trem_int.factor = factor(data$new_mds_neu_trem_int,levels=c("0","1","999","888","777"))
data$new_mds_neu_trem_rest.factor = factor(data$new_mds_neu_trem_rest,levels=c("0","1","999","888","777"))
data$new_mds_neu_trem_pos.factor = factor(data$new_mds_neu_trem_pos,levels=c("0","1","999","888","777"))
data$new_mds_neu_trem_irm.factor = factor(data$new_mds_neu_trem_irm,levels=c("0","1","999","888","777"))
data$new_mds_neu_trem_head.factor = factor(data$new_mds_neu_trem_head,levels=c("0","1","999","888","777"))
data$new_mds_neu_atax.factor = factor(data$new_mds_neu_atax,levels=c("0","1","999","888","777"))
data$new_mds_ne_ga.factor = factor(data$new_mds_ne_ga,levels=c("0","1","999","777"))
data$new_mds_med_park.factor = factor(data$new_mds_med_park,levels=c("0","1","999","888","777"))
data$new_mds_ne_pf.factor = factor(data$new_mds_ne_pf,levels=c("0","1","999","777"))
data$new_mds_ne_pfmf.factor = factor(data$new_mds_ne_pfmf,levels=c("0","1","999","777"))
data$new_mds_ne_pfit.factor = factor(data$new_mds_ne_pfit,levels=c("0","1","999","777"))
data$new_mds_ne_pfprt.factor = factor(data$new_mds_ne_pfprt,levels=c("0","1","999","777"))
data$new_mds_ne_pfsg.factor = factor(data$new_mds_ne_pfsg,levels=c("0","1","999","777"))
data$scid_dxcode1.factor = factor(data$scid_dxcode1,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
data$scid_dxcode2.factor = factor(data$scid_dxcode2,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
data$scid_dxcode3.factor = factor(data$scid_dxcode3,levels=c("1","2","3","4","5","6","7","8","10","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","44","777","888","999"))
data$new_mds_med_lup.factor = factor(data$new_mds_med_lup,levels=c("0","1","999","888","777"))
data$new_mds_med_ra.factor = factor(data$new_mds_med_ra,levels=c("0","1","999","888","777"))
data$new_mds_med_mswk.factor = factor(data$new_mds_med_mswk,levels=c("0","1","999","888","777"))
data$new_mds_med_ana.factor = factor(data$new_mds_med_ana,levels=c("0","1","3","999","888","777"))
data$new_mds_med_sjo.factor = factor(data$new_mds_med_sjo,levels=c("0","1","999","888","777"))
data$new_mds_med_ray.factor = factor(data$new_mds_med_ray,levels=c("0","1","999","888","777"))
data$new_mds_med_pulm.factor = factor(data$new_mds_med_pulm,levels=c("0","1","999","888","777"))
data$mri_cere_atr.factor = factor(data$mri_cere_atr,levels=c("0","1","3","4","999"))
data$mri_cerebel_atr.factor = factor(data$mri_cerebel_atr,levels=c("0","1","3","4","999"))
data$mri_cere_wm_hyper.factor = factor(data$mri_cere_wm_hyper,levels=c("0","1","3","4","999"))
data$mri_cerebel_wm_hyper.factor = factor(data$mri_cerebel_wm_hyper,levels=c("0","1","3","4","999"))
data$mri_mcp_wm_hyper.factor = factor(data$mri_mcp_wm_hyper,levels=c("0","1","3","4","999"))
data$mri_pons_wm_hyper.factor = factor(data$mri_pons_wm_hyper,levels=c("0","1","3","4","999"))
data$mri_subins_wm_hyper.factor = factor(data$mri_subins_wm_hyper,levels=c("0","1","3","4","999"))
data$mri_peri_wm_hyper.factor = factor(data$mri_peri_wm_hyper,levels=c("0","1","3","4","999"))
data$mri_splen_wm_hyper.factor = factor(data$mri_splen_wm_hyper,levels=c("0","1","3","4","999"))
data$mri_genu_wm_hyper.factor = factor(data$mri_genu_wm_hyper,levels=c("0","1","999"))
data$mri_corp_call_thick.factor = factor(data$mri_corp_call_thick,levels=c("0","1","999"))

levels(data$redcap_event_name.factor)=c("GP4 - Visit 1","GP4 - Visit 2","GP4 - Visit 3","GP4 - Visit 4","GP4 - Single Visit","GP4 - Participant Survey")
levels(data$sex.factor)=c("Female","Male")
levels(data$new_mds_psy_drug.factor)=c("None","Past Only","Present","no response","NA","question not asked at time of data entry; check records")
levels(data$new_mds_psy_drug_marij.factor)=c("None","Past Only","Present","no response","NA","question not asked at time of data entry; check records")
levels(data$new_mds_psy_alco.factor)=c("None","Past Only","Present","no response","NA","question not asked at time of data entry; check records")
levels(data$new_mds_med_thyca.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_skin.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_mela.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_proca.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_neu_trem_int.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_neu_trem_rest.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_neu_trem_pos.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_neu_trem_irm.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_neu_trem_head.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_neu_atax.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_ne_ga.factor)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(data$new_mds_med_park.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_ne_pf.factor)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(data$new_mds_ne_pfmf.factor)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(data$new_mds_ne_pfit.factor)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(data$new_mds_ne_pfprt.factor)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(data$new_mds_ne_pfsg.factor)=c("No","Yes","No Response","Question not asked at time of data entry; check records")
levels(data$scid_dxcode1.factor)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(data$scid_dxcode2.factor)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(data$scid_dxcode3.factor)=c("Bipolar I Disorder (MD01)","Bipolar II Disorder (MD02)","Other Bipolar Disorder (MD03)","Major Depressive Disorder (MD04)","Dysthymic Disorder (MD05)","Depressive Disorder NOS (MD06)","Mood Disorder Due to GMC (MD07)","Substance-Induced Mood Disorder (MD08)","Primary Psychotic Symptom (PS01)","Alcohol (SUD17)","Sedative-Hypnotic-Anxioly (SUD18)","Cannabis (SUD19)","Stimulants (SUD20)","Opiod (SUD21)","Cocaine (SUD22)","Hallucinogenics/ PCP (SUD23)","Poly Drug (SUD24)","Substance Abuse Other (SUD25)","Panic Disorder (ANX26)","Agoraphobia without Panic (ANX27)","Social Phobia (ANX28)","Specific Phobia (ANX29)","Obsessive Compulsive (ANX30)","Posttraumatic Stress (ANX31)","Generalized Anxiety (ANX32)","Anxiety Due To GMC (ANX33)","Substance-Induced Anxiety (ANX34)","Anxiety Disorder NOS (ANX35)","Somatization Disorder (SOM36)","Pain Disorder (SOM37)","Undifferentiated Somatoform (SOM38)","Hypochondriasis (SOM39)","Body Dysmorphic (SOM40)","Adjustment Disorder (ADJ44)","Other Dx Not Listed","Not Applicable","None Listed or Incomplete Data")
levels(data$new_mds_med_lup.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_ra.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_mswk.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_ana.factor)=c("No","Yes","Unknown","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_sjo.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_ray.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$new_mds_med_pulm.factor)=c("No","Yes","No Response","NA","Question not asked at time of data entry; check records")
levels(data$mri_cere_atr.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_cerebel_atr.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_cere_wm_hyper.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_cerebel_wm_hyper.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_mcp_wm_hyper.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_pons_wm_hyper.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_subins_wm_hyper.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_peri_wm_hyper.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_splen_wm_hyper.factor)=c("None","Mild","Moderate","Severe","Missing/Refused")
levels(data$mri_genu_wm_hyper.factor)=c("No","Yes","Missing/Refused")
levels(data$mri_corp_call_thick.factor)=c("Normal","Thin","Missing/Refused")
