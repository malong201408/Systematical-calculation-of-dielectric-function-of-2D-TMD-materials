(* ::Package:: *)


(* ::Input::Initialization:: *)
ClearAll["Global`*"];
(*SetDirectory[NotebookDirectory[]];*)

(* ::Input::Initialization:: *)
SetSystemOptions["ParallelOptions"->{"MKLThreadNumber"->4,"ParallelThreadNumber"->4}];

(* ::Input::Initialization:: *)
c=3*10^18;
\[HBar]=6.582119569*10^-16;
kb=8.6173303*10^-5;
T20=300;
DT0=100;
d00=20;
sig2dIm=Import["#1sig_Imxx.dat"];
sig2dRe=Import["#1sig_Rxx.dat"];
ene=sig2dIm[[2;;150,1]];
sigIm=sig2dIm[[2;;150,2]];
sigRe=sig2dRe[[2;;150,2]];
\[Sigma]1=sigRe;
\[Sigma]11=\[Sigma]1/c; 
\[Sigma]2=sigIm;
\[Sigma]22=\[Sigma]2/c;  
\[Sigma]=\[Sigma]1+I*\[Sigma]2;
d0=Table[2*i,{i,1,5}];
d10=Table[20*i,{i,1,5}];
d100=Table[200*i,{i,1,5}];
d1000=Table[1000+200*i,{i,1,5}];
T2=Table[(250+50*i),{i,1,10}];
DT=Table[(50+50*i),{i,1,10}];
\[Omega]=ene/\[HBar];
\[CapitalDelta]ene=ene[[2]]-ene[[1]];
sigbb=5.6705*10^-8*6.242*10^-2;
Qbb=sigbb*((T20+DT0)^4-(T20)^4);


(* ::Input::Initialization:: *)
Rpp1[q_]:=(\[Lambda]*2*\[Pi]*(\[Sigma]1+I*\[Sigma]2))/c/(1+(\[Lambda]*2*\[Pi]*(\[Sigma]1+I*\[Sigma]2))/c)/.{\[Sigma]1->\[Sigma]11*c, \[Sigma]2->\[Sigma]22*c,\[Lambda]->Sqrt[1-q^2]};
Tpp1[q_]:=1-Rpp1[q]/.{\[Sigma]1->\[Sigma]11*c, \[Sigma]2->\[Sigma]22*c,\[Lambda]->Sqrt[1-q^2]};
Rss1[q_]:=-((2*\[Pi])/((\[Lambda]*c)/(\[Sigma]1+I*\[Sigma]2)+2*\[Pi]))/.{\[Sigma]1->\[Sigma]11*c, \[Sigma]2->\[Sigma]22*c,\[Lambda]->Sqrt[1-q^2]};
Tss1[q_]:=1+Rss1[q]/.{\[Sigma]1->\[Sigma]11*c, \[Sigma]2->\[Sigma]22*c,\[Lambda]->Sqrt[1-q^2]};


(* ::Input::Initialization:: *)
Sp1[d_,q1_]:=  ((1-Rpp1[q1]*Conjugate[Rpp1[q1]]-Tpp1[q1]*Conjugate[Tpp1[q1]])^2)/((1-E^(2 I d*\[Omega]/c*Sqrt[1-q1^2])*(Rpp1[q1])^2)*Conjugate[(1-E^(2 I d*\[Omega]/c*Sqrt[1-q1^2])*(Rpp1[q1])^2)]);
Ss1[d_,q1_]:=  ((1-Rss1[q1]*Conjugate[Rss1[q1]]-Tss1[q1]*Conjugate[Tss1[q1]])^2)/((1-E^(2 I d*\[Omega]/c*Sqrt[1-q1^2]) *(Rss1[q1])^2)*Conjugate[(1-E^(2 I d*\[Omega]/c*Sqrt[1-q1^2]) *(Rss1[q1])^2)]);
Sp2[d_,q2_]:=E^(-2*\[Omega]/c*Sqrt[q2^2-1]*d)*  ((Im[Rpp1[q2]])^2)/((1-E^(-2*\[Omega]/c*Sqrt[q2^2-1]*d) (Rpp1[q2])^2)*Conjugate[(1-E^(-2*\[Omega]/c*Sqrt[q2^2-1]*d) (Rpp1[q2])^2)] );
Ss2[d_,q2_]:=E^(-2*\[Omega]/c*Sqrt[q2^2-1]*d)*  ((Im[Rss1[q2]])^2)/((1-E^(-2*\[Omega]/c*Sqrt[q2^2-1]*d) (Rss1[q2])^2) *Conjugate[(1-E^(-2*\[Omega]/c*Sqrt[q2^2-1]*d) (Rss1[q2])^2)]);

(* ::Input::Initialization:: *)
intprop[d_,q_]:=1/(2*\[Pi])*(\[Omega]/c)^2*q*(Sp1[d,q]+Ss1[d,q]);
inteva[d_,q_]:= 4*1/(2*\[Pi])*(\[Omega]/c)^2*q*(Sp2[d,q]+Ss2[d,q]);


(* ::Input::Initialization:: *)
Qprop[d_?NumericQ]:=NIntegrate[intprop[d,q], {q,0,1},Method->{"GlobalAdaptive","SingularityHandler"->"IMT"},MaxRecursion->50];
Qeva[d_?NumericQ]:=NIntegrate[inteva[d,q], {q,1,+\[Infinity]},Method->{"GlobalAdaptive","SingularityHandler"->"IMT"},MaxRecursion->50];


(* ::Input::Initialization:: *)
plot=Table[{},{j,1,Length[d0]}];
Szprop=Table[None,{l,1,Length[d0]}];
Szevan=Table[None,{l,1,Length[d0]}];
Sztot=Table[None,{l,1,Length[d0]}];
For[i=1,i<=Length[d0],i++,
   distance=d0[[i]];
   sep=Table[distance,{l,1,Length[ene]}];
   intT=1/2*(ene/(2*\[Pi]))*(Coth[ene/(2*kb*(T20+DT0))]-Coth[ene/(2*kb*T20)]);
   intTJoule=intT*16.0218;
   Sprop=(Total[Qprop[distance]*intT]-(1/2)*Last[Qprop[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Spropbb=Sprop/Qbb;
   Seva=(Total[Qeva[distance]*intT]-(1/2)*Last[Qeva[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Sevabb=Seva/Qbb;
   listQ=Transpose[{ene,intTJoule,Qprop[distance],Qeva[distance]}];
   Export["Q_d0_#1_"<>ToString[distance]<>".dat",listQ];
   Szprop[[i]]=Spropbb;
   Szevan[[i]]=Sevabb;
   Sztot[[i]]=Spropbb+Sevabb;
   ]
Export["LQdata_d0_#1_"<>ToString[distance]<>".dat",Transpose[{d0,Szprop,Szevan,Sztot}]];


(* ::Input::Initialization:: *)
plot=Table[{},{j,1,Length[d10]}];
Szprop=Table[None,{l,1,Length[d10]}];
Szevan=Table[None,{l,1,Length[d10]}];
Sztot=Table[None,{l,1,Length[d10]}];
For[i=1,i<=Length[d10],i++,
   distance=d10[[i]];
   sep=Table[distance,{l,1,Length[ene]}];
   intT=1/2*(ene/(2*\[Pi]))*(Coth[ene/(2*kb*(T20+DT0))]-Coth[ene/(2*kb*T20)]);
   intTJoule=intT*16.0218;
   Sprop=(Total[Qprop[distance]*intT]-(1/2)*Last[Qprop[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Spropbb=Sprop/Qbb;
   Seva=(Total[Qeva[distance]*intT]-(1/2)*Last[Qeva[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Sevabb=Seva/Qbb;
   listQ=Transpose[{ene,intTJoule,Qprop[distance],Qeva[distance]}];
   Export["Q_d10_#1_"<>ToString[distance]<>".dat",listQ];
   Szprop[[i]]=Spropbb;
   Szevan[[i]]=Sevabb;
   Sztot[[i]]=Spropbb+Sevabb;
   ]
Export["LQdata_d10_#1_"<>ToString[distance]<>".dat",Transpose[{d10,Szprop,Szevan,Sztot}]];


(* ::Input::Initialization:: *)
plot=Table[{},{j,1,Length[d100]}];
Szprop=Table[None,{l,1,Length[d100]}];
Szevan=Table[None,{l,1,Length[d100]}];
Sztot=Table[None,{l,1,Length[d100]}];
For[i=1,i<=Length[d100],i++,
   distance=d100[[i]];
   sep=Table[distance,{l,1,Length[ene]}];
   intT=1/2*(ene/(2*\[Pi]))*(Coth[ene/(2*kb*(T20+DT0))]-Coth[ene/(2*kb*T20)]);
   intTJoule=intT*16.0218;
   Sprop=(Total[Qprop[distance]*intT]-(1/2)*Last[Qprop[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Spropbb=Sprop/Qbb;
   Seva=(Total[Qeva[distance]*intT]-(1/2)*Last[Qeva[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Sevabb=Seva/Qbb;
   listQ=Transpose[{ene,intTJoule,Qprop[distance],Qeva[distance]}];
   Export["Q_d100_#1_"<>ToString[distance]<>".dat",listQ];
   Szprop[[i]]=Spropbb;
   Szevan[[i]]=Sevabb;
   Sztot[[i]]=Spropbb+Sevabb;
   ]
Export["LQdata_d100_#1_"<>ToString[distance]<>".dat",Transpose[{d100,Szprop,Szevan,Sztot}]];


(* ::Input::Initialization:: *)
plot=Table[{},{j,1,Length[d1000]}];
Szprop=Table[None,{l,1,Length[d1000]}];
Szevan=Table[None,{l,1,Length[d1000]}];
Sztot=Table[None,{l,1,Length[d1000]}];
For[i=1,i<=Length[d1000],i++,
   distance=d1000[[i]];
   sep=Table[distance,{l,1,Length[ene]}];
   intT=1/2*(ene/(2*\[Pi]))*(Coth[ene/(2*kb*(T20+DT0))]-Coth[ene/(2*kb*T20)]);
   intTJoule=intT*16.0218;
   Sprop=(Total[Qprop[distance]*intT]-(1/2)*Last[Qprop[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Spropbb=Sprop/Qbb;
   Seva=(Total[Qeva[distance]*intT]-(1/2)*Last[Qeva[distance]*intT])*(\[CapitalDelta]ene/\[HBar]);
   Sevabb=Seva/Qbb;
   listQ=Transpose[{ene,intTJoule,Qprop[distance],Qeva[distance]}];
   Export["Q_d1000_#1_"<>ToString[distance]<>".dat",listQ];
   Szprop[[i]]=Spropbb;
   Szevan[[i]]=Sevabb;
   Sztot[[i]]=Spropbb+Sevabb;
   ]
Export["LQdata_d1000_#1_"<>ToString[distance]<>".dat",Transpose[{d1000,Szprop,Szevan,Sztot}]];

