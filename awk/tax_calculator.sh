#!/usr/bin/bash

payroll_file=$1

###########################################################
# Phase 1 -> w2_info
###########################################################
# Filter out irrelevant columns
# Gross income = sum of wages and bonuses

awk -F ',' '{print $3 "," $4 "," $8+$11 "," $10}' "$payroll_file" > w2_info

###########################################################
# Phase 2 -> agg_data
###########################################################
 
awk -F -f data_aggregation.awk < w2_info > agg_data

# HR wants to know the average earnings of their employees, 
# the average amount employees have withhold, 
# the highest total earnings, 
# and the lowest total earnings.
