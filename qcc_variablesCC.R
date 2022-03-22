#install.packages("qcc")
library(qcc)
?qcc

#NOTE: dataframes used in qcc are NOT tidy, there are multiple observations per row
diameter_retro<-read.csv("https://raw.githubusercontent.com/tmatis12/datafiles/main/diameter_retrospec_qc.csv") #data from retrospective analysis
diameter_retro
diameter_online<-read.csv("https://raw.githubusercontent.com/tmatis12/datafiles/main/diameter_online_qc.csv") #data collected in online monitoring
diameter_online

##### Plot an X-Bar Chart for Online Data with known UCL, LCL, and CL ####
# assume CL=74, UCL=74.015, LCL=73.895
qcc(diameter_online,type="xbar",center=74,limits=c(73.985,74.015))
qcc(diameter_online,type="xbar",center=74,limits=c(73.985,74.015),
    data.name="Piston Rings Data") #add unique title 
qcc(diameter_online,type="xbar",center=74,limits=c(73.985,74.015),
    data.name="Piston Rings Data",
    add.stats=FALSE) #remove stat at bottom
qcc(diameter_online,type="xbar",center=74,limits=c(73.985,74.015),
    title="X-Bar Chart: Piston Rings Data \n Subgroups of Size n=5", #\n means new line
    xlab="Subgroup Number", #specify x-axis label
    ylab="Subgroup Average", #specify y-axis label
    add.stats=FALSE)

##### Plot an X-Bar Chart for Online Data with known mean and st.dev ####
# assume the mean is known to be 74 with a populations standard deviation of 0.02
qcc(diameter_online,type="xbar",center=74,std.dev=.015)
qcc(diameter_online,type="xbar",center=74,std.dev=.015,ylim=c(73.965,74.035))

##### Plot an X-Bar Chart using R for Retrospective Data ####
qcc(diameter_retro,type="xbar") 
diameter_retro<-diameter_retro[-26,] #eliminate subgroup 26
diameter_retro
qcc(diameter_retro,type="xbar") #defaults to range based estimate of st.dev. since subgroup small
qcc(diameter_retro,type="xbar",std.dev=sd.R(diameter_retro),
    title="X-Bar Chart using R \n Subgroups of Size n=5")

##### Plot an R Chart for Retrospective Data ####
qcc(diameter_retro,type="R")

##### Plot an X-Bar Chart using S for Retrospective Data ####
qcc(diameter_retro,type="xbar",std.dev=sd.S(diameter_retro),
    title="X-Bar Chart using S \n Subgroups of Size n=5")

##### Plot an S Chart for Retrospective Data ####
qcc(diameter_retro,type="S")

##### Plot an X-Bar Chart using R with both Retrospective and Online Data ####
qcc(diameter_retro,type="xbar",newdata=diameter_online) 
qcc(diameter_retro,type="xbar",newdata=diameter_online,
    title="X-Bar Chart using R \n Retrospective and Online Piston Rings Data \n Subgroup Size n=5",
    xlab="Subroup Number",
    ylab="Subroup Average") #add title

##### Plot an R Chart with both Retrospective and Online Data ####
qcc(diameter_retro,type="R",newdata=diameter_online) 

#########################  End of Analysis #############################
