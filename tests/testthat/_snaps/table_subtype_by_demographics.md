# `table_subtype_by_demographics()` produces consistent results

    Code
      print(table_subtype_by_demographics(patient_data, table), print_engine = "kable")
    Output
      
      
      |**Characteristic**     | **Overall**  N = 217 | **Type 1**  N = 63 | **Type 2**  N = 64 | **Type 3**  N = 50 | **Type 4**  N = 40 | **p-value** |
      |:----------------------|:--------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:-----------:|
      |FX3*                   |                      |                    |                    |                    |                    |    0.712    |
      |CGG 55-99              |      167 (100%)      |      49 (29%)      |      52 (31%)      |      37 (22%)      |      29 (17%)      |             |
      |CGG 100-199            |      50 (100%)       |      14 (28%)      |      12 (24%)      |      13 (26%)      |      11 (22%)      |             |
      |Gender                 |                      |                    |                    |                    |                    |    0.323    |
      |Male                   |      130 (100%)      |      32 (25%)      |      42 (32%)      |      30 (23%)      |      26 (20%)      |             |
      |Female                 |      87 (100%)       |      31 (36%)      |      22 (25%)      |      20 (23%)      |      14 (16%)      |             |
      |Primary Race/Ethnicity |                      |                    |                    |                    |                    |    0.211    |
      |White                  |      170 (100%)      |      53 (31%)      |      50 (29%)      |      34 (20%)      |      33 (19%)      |             |
      |Hispanic               |       8 (100%)       |      1 (13%)       |      1 (13%)       |      3 (38%)       |      3 (38%)       |             |
      |Other                  |       7 (100%)       |      1 (14%)       |      4 (57%)       |      2 (29%)       |       0 (0%)       |             |
