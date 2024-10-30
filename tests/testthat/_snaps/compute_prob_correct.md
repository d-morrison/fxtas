# pander method for `prob_correct` objects produces consistent results

    Code
      pander(compute_prob_correct(control_data, max_prob = 0.95, biomarker_levels = biomarker_levels))
    Output
      
      ----------------------------------------------------------------------------------------------------------
                 Biomarker              # controls with data   # at baseline   % at baseline   Est. Pr(correct) 
      -------------------------------- ---------------------- --------------- --------------- ------------------
                Head tremor                      5                   5             100%              95%        
      
              Intention tremor                   36                 34             94.4%            94.4%       
      
               Resting tremor                    37                 35             94.6%            94.6%       
      
              Postural tremor                    36                 35             97.2%             95%        
      
            Intermittent tremor                  32                 30             93.8%            93.8%       
      
                   Ataxia                        35                 32             91.4%            91.4%       
      
             Ataxia: severity*                   37                 35             94.6%            94.6%       
      
             FXTAS Stage (0-5)*                  39                 39             100%              95%        
      
           parkinsonian features                 6                   6             100%              95%        
      
                Masked faces                     32                 32             100%              95%        
      
               Increased tone                    30                 30             100%              95%        
      
            Pill-rolling tremor                  32                 32             100%              95%        
      
                 Stiff gait                      30                 30             100%              95%        
      
                 Parkinsons                      5                   5             100%              95%        
      
              MRI: Cerebellar                    1                   1             100%              95%        
      
               MRI: Cerebral                     1                   1             100%              95%        
      
              Splenium (CC)-WM                   1                   1             100%              95%        
               Hyperintensity                                                                                   
      
        Genu (CC)-WM Hyperintensity              1                   1             100%              95%        
      
         Corpus Callosum-Thickness               1                   1             100%              95%        
      
             MMSE total score*                   7                   7             100%              95%        
      
             BDS-2 Total Score*                  40                 33             82.5%            82.5%       
      
            SCID: Mood Disorders                 35                 20             57.1%            57.1%       
      
       SCID: Substance Use Disorders             34                 29             85.3%            85.3%       
      
          SCID: Anxiety Disorders                35                 12             34.3%            34.3%       
      
         SCID: Somatoform Disorders              34                 32             94.1%            94.1%       
      
            SWM Between errors*                  25                 14              56%              56%        
      
        PAL Total errors (adjusted)*             25                  9              36%              36%        
      
       RTI Five-choice movement time*            25                 25             100%              95%        
      
                Hypothyroid                      27                 26             96.3%             95%        
      
                Hyperthyroid                     27                 26             96.3%             95%        
      
          any autoimmune disorder                37                 36             97.3%             95%        
      ----------------------------------------------------------------------------------------------------------
      
