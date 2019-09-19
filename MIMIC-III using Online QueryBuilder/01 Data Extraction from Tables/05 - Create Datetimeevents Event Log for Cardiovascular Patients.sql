SELECT DISTINCT
  datetimeevents.subject_id, 
  datetimeevents.hadm_id,
  datetimeevents.icustay_id, 
  d_items.category AS category, 
  d_items.label AS activity, 
  datetimeevents.charttime As charttime,
  caregivers.label AS caregiver
FROM 
  mimiciii.datetimeevents, 
  mimiciii.d_items,
  mimiciii.diagnoses_icd,
  mimiciii.caregivers
WHERE 
  datetimeevents.charttime IS NOT NULL AND
  datetimeevents.hadm_id = diagnoses_icd.hadm_id AND  
  datetimeevents.itemid = d_items.itemid AND
  d_items.label IS NOT NULL AND
  caregivers.cgid = datetimeevents.cgid AND
  diagnoses_icd.icd9_code BETWEEN '390%' AND '460%' -- Change the values for different diseases
ORDER BY subject_id, hadm_id, icustay_id, charttime, category, activity;