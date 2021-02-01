# -*- coding: utf-8 -*-
"""
Created on Mon May  4 12:00:13 2020

@author: prie0048
"""
import numpy as np
import pandas as pd
import pylab as pl
import matplotlib.pyplot as plt
from skmisc.loess import loess


####Read AWQC Coorong data export and replace unit symbols with text 
file = pd.read_excel ('U:\Coorong Project\Python\Task1.1\Coorong AWQC Data 1995_2020.xlsx', sheet_name='Sheet1', dtype=object, encoding='iso8859_15')
dfraw = file.replace({"µS/cm": "uS/cm", "µg/L": "ug/L", "°C":"celsius"})


####Pivot data table with units in the exported csv file
dfraw["AnalysisUnits"] = dfraw["Component "] + " (" + dfraw["Units"] + ")" 
df1 = pd.pivot_table(dfraw,index=["Sampling Point ","Sampled Date "],columns=["AnalysisUnits"],values=["Result Value"])
df1.to_csv('U:\Coorong Project\Python\Task1.1\Coorong AWQC Data 1995_2020_pivoted.csv')


####Remove the duplicated sample names               
df_new = df1.rename(index={'EPA - Murray Mouth': 'Murray Mouth', 'Coorong Sub Lagoon 1 Tauwitcherie': 'Tauwitchere', 'EPA -  Tauwitchere': 'Tauwitchere', 'Coorong Sub Lagoon 2 Mark Pt': 'Mark Pt', 'EPA - Mark Point': 'Mark Pt', 'Coorong Sub Lagoon 3 Long Point': 'Long Point', 'EPA - Long Point': 'Long Point', 'Coorong Sub Lagoon 4 Noonameena': 'Noonameena', 'Coorong Sub Lagoon 5 Bonneys': 'Bonneys', 'Coorong Sub Lagoon 6 McGrath Flat North': 'McGrath Flat Nth', 'EPA - McGrath Flat North': 'McGrath Flat Nth', 'Coorong Sub Lagoon 7 Parnka Point': 'Parnka Pt', 'EPA - Parnka Point Boat Ramp': 'Parnka Pt', 'Coorong Sub Lagoon 8': 'Villa de Yumpa', 'EPA - Villa de Yumpa': 'Villa de Yumpa', 'Coorong Sub Lagoon Stony Well': 'Stony Well', 'EPA - Stoney Well': 'Stony Well', 'EPA - Nth Jack Point': 'North Jacks Pt', 'Coorong Sub Lagoon 10 Nth Jacks Point': 'North Jacks Pt', 'Coorong Sub Lagoon 11 Sth Policemans Point': 'South Policemans Pt', 'EPA - Seagull Island': 'South Policemans Pt', 'EPA - Snipe Point': 'Snipe Point', 'EPA - 1.8km West Salt Creek': '1.8km west of Salt Creek', 'Coorong Sub Lagoon 12 Sth Salt Creek': 'South Salt Creek', 'EPA - Sth Salt Creek': 'South Salt Creek', 'EPA - 3.2km South Salt Creek': '3.2km south of Salt Ck'})
df_new.to_csv('U:\Coorong Project\Python\Task1.1\Coorong AWQC Data 1995_2020_renamed.csv')


####Merge renamed data file with location data after cleaning up column names and blank rows    
data = pd.read_csv ('U:\Coorong Project\Python\Task1.1\Coorong AWQC Data 1995_2020_renamed.csv', skiprows=1)
data.columns.values[0] = 'Sampling_point'
data.columns.values[1] = 'Date'
data = data.drop([0])
loc = pd.read_csv ('U:\Coorong Project\Python\Task1.1\Coorong Location.csv')
result = pd.merge(data, loc, on='Sampling_point')
result.columns = result.columns.str.replace('- ', '').str.replace('/', '_').str.replace(' ', '_').str.replace('(', '').str.replace(')', '').str.replace('+', '')


####Calculate TN by summing TKN and NOx
TN = result.TKN_as_Nitrogen_mg_L + result.Nitrate__Nitrite_as_N_mg_L


####Add TN to dataframe df3 and remove zero values
dfn = pd.concat([result, TN], axis=1, sort=False)
dfn.columns.values[-1] = 'TN'
dfn = dfn[dfn!=0]

####Exports dataset used for plotting - has only continuous sampled sites under one name with location data included
dfn.to_csv('U:\Coorong Project\Python\Task1.1\Coorong AWQC Data 1995_2020_output.csv', index=False)


####Plot Figures

####Get required datafiles
df = pd.read_csv ('U:\Coorong Project\Python\Task1.1\Coorong AWQC Data 1995_2020_output.csv')
df.Date = pd.to_datetime(df.Date, format='%Y-%m-%d')
sc = pd.read_csv ('U:\Coorong Project\Python\Task1.1\Salt_Creek.csv', parse_dates=['Date'], dayfirst=True)
bf = pd.read_csv ('U:\Coorong Project\Python\Task1.1\BarrageFlows.csv', parse_dates=['Date'], dayfirst=True)


#### Figure - mean and standard error with distance to murray mouth
#### gives mean and standard error of an analysis type for each sample location
cond_mean = df.groupby('Sampling_point')['Conductivity_uS_cm'].mean().to_frame().reset_index()
cond_se = df.groupby('Sampling_point')['Conductivity_uS_cm'].sem().to_frame().reset_index()
cond1 = pd.merge(cond_mean, loc, on='Sampling_point')
cond = pd.merge(cond1, cond_se, on='Sampling_point')

TN_mean = df.groupby('Sampling_point')['TN'].mean().to_frame().reset_index()
TN_se = df.groupby('Sampling_point')['TN'].sem().to_frame().reset_index()
TN1 = pd.merge(TN_mean, loc, on='Sampling_point')
TN = pd.merge(TN1, TN_se, on='Sampling_point')

TP_mean = df.groupby('Sampling_point')['Phosphorus_Total_mg_L'].mean().to_frame().reset_index()
TP_se = df.groupby('Sampling_point')['Phosphorus_Total_mg_L'].sem().to_frame().reset_index()
TP1 = pd.merge(TP_mean, loc, on='Sampling_point')
TP = pd.merge(TP1, TP_se, on='Sampling_point')

NH4_mean = df.groupby('Sampling_point')['Ammonia_as_N_mg_L'].mean().to_frame().reset_index()
NH4_se = df.groupby('Sampling_point')['Ammonia_as_N_mg_L'].sem().to_frame().reset_index()
NH41 = pd.merge(NH4_mean, loc, on='Sampling_point')
NH4 = pd.merge(NH41, NH4_se, on='Sampling_point')

NOX_mean = df.groupby('Sampling_point')['Nitrate__Nitrite_as_N_mg_L'].mean().to_frame().reset_index()
NOX_se = df.groupby('Sampling_point')['Nitrate__Nitrite_as_N_mg_L'].sem().to_frame().reset_index()
NOX1 = pd.merge(NOX_mean, loc, on='Sampling_point')
NOX = pd.merge(NOX1, NOX_se, on='Sampling_point')

P_mean = df.groupby('Sampling_point')['Phosphorus_Filterable_Reactive_as_P_mg_L'].mean().to_frame().reset_index()
P_se = df.groupby('Sampling_point')['Phosphorus_Filterable_Reactive_as_P_mg_L'].sem().to_frame().reset_index()
P1 = pd.merge(P_mean, loc, on='Sampling_point')
P = pd.merge(P1, P_se, on='Sampling_point')

Chla_mean = df.groupby('Sampling_point')['Chlorophyll_a_ug_L'].mean().to_frame().reset_index()
Chla_se = df.groupby('Sampling_point')['Chlorophyll_a_ug_L'].sem().to_frame().reset_index()
Chla1 = pd.merge(Chla_mean, loc, on='Sampling_point')
Chla = pd.merge(Chla1, Chla_se, on='Sampling_point')

tur_mean = df.groupby('Sampling_point')['Turbidity_NTU'].mean().to_frame().reset_index()
tur_se = df.groupby('Sampling_point')['Turbidity_NTU'].sem().to_frame().reset_index()
tur1 = pd.merge(tur_mean, loc, on='Sampling_point')
tur = pd.merge(tur1, tur_se, on='Sampling_point')

###plot data
plt.rc('font', size=8) 
f = plt.figure(figsize=(10,14))
f.add_subplot(4, 2, 1) 
plt.errorbar(cond.Distance_Murray_Mouth, cond.Conductivity_uS_cm_x, yerr=cond.Conductivity_uS_cm_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Conductivity (μS/cm)')
plt.axvline(x=64, linewidth=1, linestyle='--', color='grey')

f.add_subplot(4, 2, 2) 
plt.errorbar(TN.Distance_Murray_Mouth, TN.TN_x, yerr=TN.TN_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Total Nitrogen (mg/L)')
plt.axvline(x=64, linewidth=1, linestyle='--', color='grey')
plt.axhline(y=1, linewidth=1, linestyle='-', color='blue')

f.add_subplot(4, 2, 3) 
plt.errorbar(TP.Distance_Murray_Mouth, TP.Phosphorus_Total_mg_L_x, yerr=TP.Phosphorus_Total_mg_L_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Total Phosphorus (mg/L)')
plt.axvline(x=64, linewidth=1, linestyle='--', color='grey')
plt.axhline(y=0.1, linewidth=1, linestyle='-', color='blue')

f.add_subplot(4, 2, 4) 
plt.errorbar(NH4.Distance_Murray_Mouth, NH4.Ammonia_as_N_mg_L_x, yerr=NH4.Ammonia_as_N_mg_L_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Ammonium (as N mg/L)')
plt.axvline(x=56, linewidth=1, linestyle='--', color='grey')
plt.axhline(y=0.05, linewidth=1, linestyle='-', color='blue')

f.add_subplot(4, 2, 5) 
plt.errorbar(P.Distance_Murray_Mouth, P.Phosphorus_Filterable_Reactive_as_P_mg_L_x, yerr=P.Phosphorus_Filterable_Reactive_as_P_mg_L_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Filterable reactive Phosphorus (as P mg/L')
plt.axvline(x=64, linewidth=1, linestyle='--', color='grey')
plt.axhline(y=0.01, linewidth=1, linestyle='-', color='blue')

f.add_subplot(4, 2, 6) 
plt.errorbar(NOX.Distance_Murray_Mouth, NOX.Nitrate__Nitrite_as_N_mg_L_x, yerr=NOX.Nitrate__Nitrite_as_N_mg_L_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Oxidised Nitrogen (as N mg/L)')
plt.axvline(x=64, linewidth=1, linestyle='--', color='grey')
plt.axhline(y=0.1, linewidth=1, linestyle='-', color='blue')

f.add_subplot(4, 2, 7) 
plt.errorbar(Chla.Distance_Murray_Mouth, Chla.Chlorophyll_a_ug_L_x, yerr=Chla.Chlorophyll_a_ug_L_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Chlorophyll a (μg/L)')
plt.axvline(x=64, linewidth=1, linestyle='--', color='grey')
plt.axhline(y=5, linewidth=1, linestyle='-', color='blue')

f.add_subplot(4, 2, 8) 
plt.errorbar(tur.Distance_Murray_Mouth, tur.Turbidity_NTU_x, yerr=tur.Turbidity_NTU_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('Turbidity (NTU)')
plt.axvline(x=64, linewidth=1, linestyle='--', color='grey')
plt.axhline(y=0.5, linewidth=1, linestyle='-', color='blue')
plt.axhline(y=10, linewidth=1, linestyle='-', color='blue')
plt.axhspan(0.5, 10, facecolor='blue', alpha=0.25)

plt.savefig('Figure_mean_distance.png')


#### Figure - time series of water quality
####Group samples together by location
grouped = df.groupby('Sampling_point')
nj = grouped.get_group('North Jacks Pt')
lp = grouped.get_group('Long Point')

#### plot data
plt.rc('font', size=8) 
f = plt.figure(figsize=(10,30))
f.add_subplot(8, 1, 1) 
plt.plot(nj.Date, nj.Conductivity_uS_cm, 'o', linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Conductivity_uS_cm, 'o', linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Conductivity (uS/cm)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(8, 1, 2) 
plt.plot(nj.Date, nj.TN, 'o', linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.TN, 'o', linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Total Nitrogen (mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper left', framealpha=1, frameon=True)

f.add_subplot(8, 1, 3) 
plt.plot(nj.Date, nj.Phosphorus_Total_mg_L, 'o', linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Phosphorus_Total_mg_L, 'o', linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Total Phosphorus (mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(8, 1, 4) 
plt.plot(nj.Date, nj.Chlorophyll_a_ug_L, 'o', linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Chlorophyll_a_ug_L, 'o', linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Chlorophyll α (μg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(8, 1, 5) 
plt.plot(nj.Date, nj.Turbidity_NTU, 'o', linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Turbidity_NTU, 'o', linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Turbidity (NTU)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(8, 1, 6) 
plt.plot(sc.Date, sc.Discharge, '-', linewidth=0.7, color='black', label = 'Salt Creek inflows')
plt.xlabel('Date')
plt.ylabel('Discharge (ML/day)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(8, 1, 7) 
plt.plot(bf.Date, bf.TotalBarrageReleasesML_day, '-', linewidth=0.7, color='black', label = 'Total')
plt.plot(bf.Date, bf.Tauwitchere, '--', linewidth=0.5, color='green', label = 'Tauwitchere')
plt.xlabel('Date')
plt.ylabel('Discharge (ML/day)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

plt.savefig('Figure_timeseries.png')

#### Figure - time series of water quality on log scale
plt.rc('font', size=8) 
f = plt.figure(figsize=(10,10))
f.add_subplot(3, 2, 1) 
plt.plot(nj.Date, nj.Ammonia_as_N_mg_L, 'o', markersize=4, linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Ammonia_as_N_mg_L, 'o', markersize=4, linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Ammonium (as N mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
pl.yscale('log')
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(3, 2, 2) 
plt.plot(nj.Date, nj.Phosphorus_Filterable_Reactive_as_P_mg_L, 'o', markersize=4, linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Phosphorus_Filterable_Reactive_as_P_mg_L, 'o', markersize=4, linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Filterable Reactive Phosphorus (as P mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
pl.yscale('log')
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(3, 2, 3) 
plt.plot(nj.Date, nj.Nitrate__Nitrite_as_N_mg_L, 'o', linewidth=1, markersize=4, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Nitrate__Nitrite_as_N_mg_L, 'o', linewidth=1, markersize=4, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('NO$_x$ (as N mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
pl.yscale('log')
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='upper left', framealpha=1, frameon=True)

f.add_subplot(3, 2, 4) 
plt.plot(nj.Date, nj.Silica_Reactive_mg_L, 'o', linewidth=1, markersize=4, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.Silica_Reactive_mg_L, 'o', linewidth=1, markersize=4, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('Reactive Silica (mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
pl.yscale('log')
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='lower center', framealpha=1, frameon=True)

plt.savefig('Figure_timeseries_log.png')

####Figure - loess curves
#### Sort the data to calculate loess curves
df = df.sort_values(by=['Conductivity_uS_cm'])
df1 = df.dropna(subset=['Conductivity_uS_cm','TN'])
df2 = df.dropna(subset=['Conductivity_uS_cm','Phosphorus_Total_mg_L'])
df3 = df.dropna(subset=['Conductivity_uS_cm','Chlorophyll_a_ug_L'])

####Calculate TRIX = ( log10 (Chl. A x aD%O x TN x TP) + 1.5) / 1.2 where Chl. A is the chlorophyll a concentration as μg l-1; aD%O is oxygen as absolute % deviation from saturation, TN is the total nitrogen as μg l-1 and TP is the total phosphorus as μg l-1. 
TN = df3.TN*1000
TP = df3.Phosphorus_Total_mg_L*1000
TRIX = (np.log10(df3.Chlorophyll_a_ug_L * (TN) * (TP) * 50) + 1.5) / 1.2

####Add TRIX to dataframe df3 
TRIX2 = pd.concat([TRIX, df3], axis=1, sort=False)
TRIX2.columns.values[0] = 'TRIX'

#### Calculate loess curves
#The span controls the fraction of points used for the local regressions. 
#The default is 0.75 
#All confidence interval are set at 95 (level = 0.05)
xN = df1.Conductivity_uS_cm
yN = df1.TN

xP = df2.Conductivity_uS_cm
yP = df2.Phosphorus_Total_mg_L

xC = df3.Conductivity_uS_cm
yC = df3.Chlorophyll_a_ug_L

df4 = TRIX2.dropna(subset=['Conductivity_uS_cm','TRIX'])
xT = df4.Conductivity_uS_cm
yT = df4.TRIX

def loess_fit(xN, yN, span=0.75):
    """
    loess fit and confidence intervals
    """
    # setup
    lo = loess(xN, yN, span=span)
    # fit
    lo.fit()
    # Predict
    prediction = lo.predict(xN, stderror=True)
    # Compute confidence intervals
    ci = prediction.confidence(0.05)
    # Since we are wrapping the functionality in a function,
    # we need to make new arrays that are not tied to the
    # loess objects
    yNfit = np.array(prediction.values)
    yNmin = np.array(ci.lower)
    yNmax = np.array(ci.upper)
    return yNfit, yNmin, yNmax

def loess_fit(xP, yP, span=0.75):
    """
    loess fit and confidence intervals
    """
    # setup
    lo = loess(xP, yP, span=span)
    # fit
    lo.fit()
    # Predict
    prediction = lo.predict(xP, stderror=True)
    # Compute confidence intervals
    ci = prediction.confidence(0.05)
    # Since we are wrapping the functionality in a function,
    # we need to make new arrays that are not tied to the
    # loess objects
    yPfit = np.array(prediction.values)
    yPmin = np.array(ci.lower)
    yPmax = np.array(ci.upper)
    return yPfit, yPmin, yPmax

def loess_fit(xC, yC, span=0.75):
    """
    loess fit and confidence intervals
    """
    # setup
    lo = loess(xC, yC, span=span)
    # fit
    lo.fit()
    # Predict
    prediction = lo.predict(xC, stderror=True)
    # Compute confidence intervals
    ci = prediction.confidence(0.05)
    # Since we are wrapping the functionality in a function,
    # we need to make new arrays that are not tied to the
    # loess objects
    yCfit = np.array(prediction.values)
    yCmin = np.array(ci.lower)
    yCmax = np.array(ci.upper)
    return yCfit, yCmin, yCmax

def loess_fit(xT, yT, span=0.75):
    """
    loess fit and confidence intervals
    """
    # setup
    lo = loess(xT, yT, span=span)
    # fit
    lo.fit()
    # Predict
    prediction = lo.predict(xT, stderror=True)
    # Compute confidence intervals
    ci = prediction.confidence(0.05)
    # Since we are wrapping the functionality in a function,
    # we need to make new arrays that are not tied to the
    # loess objects
    yTfit = np.array(prediction.values)
    yTmin = np.array(ci.lower)
    yTmax = np.array(ci.upper)
    return yTfit, yTmin, yTmax

#### plot data
plt.rc('font', size=8) 
f = plt.figure(figsize=(10,10))
f.add_subplot(2, 2, 1) 
yNfit, yNmin, yNmax = loess_fit(xN, yN)
plt.plot(xN, yN, '.', color='black', label = "_nolabel_")
plt.plot(xN, yNfit, color='green', label = 'loess fit with span 0.75')
plt.fill_between(xN, yNmin, yNmax, color='green', alpha=.25, label = '95% confidence interval')
legend = plt.legend(loc='upper left', shadow=True)
plt.xlabel('Conductivity (uS/cm)')
plt.ylabel('Total Nitrogen (mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)

f.add_subplot(2, 2, 2)
yPfit, yPmin, yPmax = loess_fit(xP, yP)
plt.plot(xP, yP, '.', color='black', label = "_nolabel_")
plt.plot(xP, yPfit, color='green', label = 'loess fit with span 0.75')
plt.fill_between(xP, yPmin, yPmax, color='green', alpha=.25, label = '95% confidence interval')
legend = plt.legend(loc='upper left', shadow=True, bbox_to_anchor=(0, 0.9))
plt.ylim([-0.05, 0.95])
plt.yticks(np.arange(0, 1, 0.1))
plt.xlabel('Conductivity (uS/cm)')
plt.ylabel('Total Phosphorus (mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)

f.add_subplot(2, 2, 3) 
yCfit, yCmin, yCmax = loess_fit(xC, yC)
plt.plot(xC, yC, '.', color='black', label = "_nolabel_")
plt.plot(xC, yCfit, color='green', label = 'loess fit with span 0.1')
plt.fill_between(xC, yCmin, yCmax, color='green', alpha=.25, label = '95% confidence interval')
legend = plt.legend(loc='upper left', shadow=True)
plt.xlabel('Conductivity (uS/cm)')
plt.ylabel('Chlorophyll α (μg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)

f.add_subplot(2, 2, 4) 
yTfit, yTmin, yTmax = loess_fit(xT, yT)
plt.plot(xT, yT, '.', color='black', label = "_nolabel_")
plt.plot(xT, yTfit, color='green', label = 'loess fit with span 0.1')
plt.fill_between(xT, yTmin, yTmax, color='green', alpha=.25, label = '95% confidence interval')
legend = plt.legend(loc='lower right', shadow=True)
plt.xlabel('Conductivity (uS/cm)')
plt.ylabel('TRIX')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)

plt.savefig('Figure_loess.png')

####Figure - nutrient and chlorophyll data
####Calculate Redfield Ratio for plotting
x = np.linspace(0,1,2)
y = 7.2258*x

####Calculate equation 4 P-limited sites in Smith (2006)
x2 = np.linspace(0.01,12,2)   #x2 = TP in umol/L
y2 = 10 ** (1.48 * np.log10(x2) + 0.61) #y2 = Chla in ug/L

####Calculate equation 5 N-limited sites in Smith (2006)
x3 = np.linspace(0.01,30,2)   #x3 = TP in umol/L
y3 = 10 ** (0.99 * np.log10(x3) + 0.11) #y3 = Chla in ug/L

#### plot data
plt.rc('font', size=8) 
f = plt.figure(figsize=(5,10))
f.add_subplot(3, 1, 1) 
plt.plot(df.Phosphorus_Total_mg_L, df.TN, 'o', markersize=2, color='black', label = '_nolabel_')
plt.plot(x, y, linewidth=1, linestyle='-', color='blue', label='Redfield ratio')
plt.xlabel('Total Phosphorus (mg/L)')
plt.ylabel('Total Nitrogen (mg/L)')
plt.xlim([-0.05, 0.95])
plt.xticks(np.arange(0, 1, 0.1))
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

f.add_subplot(3, 1, 2)

plt.plot(df.Chlorophyll_a_ug_L, df.TN, 'o', markersize=2, color='black', label = '_nolabel_')
plt.xlabel('Chlorophyll α (μg/L)')
plt.ylabel('Total Nitrogen (mg/L)')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)

f.add_subplot(3, 1, 3)
plt.plot(df.Chlorophyll_a_ug_L, df.Phosphorus_Total_mg_L, 'o', markersize=2, color='black', label = '_nolabel_')
plt.plot(y2, x2*30.974/1000, linewidth=1, linestyle='-', color='red', label='P-limited regression model')
plt.plot(y3, x3*30.974/1000, linewidth=1, linestyle='-', color='green', label='N-limited regression model')
plt.xlabel('Chlorophyll α (μg/L)')
plt.ylabel('Total Phosphorus (mg/L)')
plt.ylim([-0.05, 0.95])
plt.yticks(np.arange(0, 1, 0.1))
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
legend = plt.legend(loc='upper right', framealpha=1, frameon=True)

plt.savefig('Figure_totalnutrients.png')

####Figure - pH
#### gives mean and standard error of an analysis type for each sample location
pH_mean = df.groupby('Sampling_point')['pH_pH_units'].mean().to_frame().reset_index()
pH_se = df.groupby('Sampling_point')['pH_pH_units'].sem().to_frame().reset_index()
pH1 = pd.merge(pH_mean, loc, on='Sampling_point')
pH = pd.merge(pH1, pH_se, on='Sampling_point')

#### plot data
plt.rc('font', size=8) 
f = plt.figure(figsize=(8,10))
f.add_subplot(2, 1, 1) 
plt.errorbar(pH.Distance_Murray_Mouth, pH.pH_pH_units_x, yerr=pH.pH_pH_units_y, fmt='o', color='black', ecolor='black', elinewidth=1, capsize=3, label = '_nolabel_')
plt.xlabel('Distance from Murray mouth (km)')
plt.ylabel('pH')
plt.axvline(x=56, linewidth=1, linestyle='--', color='grey')

f.add_subplot(2, 1, 2) 
plt.plot(nj.Date, nj.pH_pH_units, 'o', linewidth=1, linestyle='--', color='black', label = 'North Jacks Point')
plt.plot(lp.Date, lp.pH_pH_units, 'o', linewidth=1, linestyle='--', color='blue', label = 'Long Point')
plt.xlabel('Date')
plt.ylabel('pH')
plt.grid(which='major', color='grey', linestyle='-', linewidth=0.4)
plt.grid(which='minor', color='grey', alpha=0.2)
plt.xlim([np.datetime64('1997-06-01'), np.datetime64('2020-06-01')])
legend = plt.legend(loc='lower right', framealpha=1, frameon=True)

plt.savefig('Figure_pH.png')