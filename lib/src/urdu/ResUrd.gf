--# -path=.:../abstract:../common:../../prelude
--
--1 Urdu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResUrd = ParamX  ** open Prelude,Predef in {

  flags optimize=all ;
  coding = utf8;

  param 
    Case = Dir | Obl | Voc ;
    Gender = Masc | Fem ;
	VTense = Subj | Perf | Imperf;
    UPerson = Pers1
	    | Pers2_Casual
	    | Pers2_Familiar 
	    | Pers2_Respect
	    | Pers3_Near
	    | Pers3_Distant;
		
	Order = ODir | OQuest ;
	
--2 For $Relative$
 
    RAgr = RNoAg | RAg Agr ;
    RCase = RC Number Case ;

-- for Numerial
   
   CardOrd = NCard | NOrd ;
  
  -----------------------------------------
  -- Urd Pronouns
  -----------------------------------------
  
   Pronoun = P Number Gender Case UPerson;
   PersPronForm = PPF Number UPerson Case;
   
-------------------------------------------
--Verbs
-------------------------------------------

    VerbForm = VF VTense UPerson Number Gender
                | Inf
                | Root
                | Inf_Obl
                | Inf_Fem;				
  oper
    Noun = {s : Number => Case => Str ; g : Gender} ;
    Verb = {s : VerbForm => Str} ;
    Preposition = {s : Str};
    DemPronForm = {s : Number => Gender => Case => Str};
    PossPronForm = {s : Number => Gender => Case => Str};
    Determiner = {s : Number => Gender => Str ; n : Number};
  
-- a useful oper
    eq : Str -> Str -> Bool = \s1,s2-> (pbool2bool (eqStr s1 s2)) ;
 
   -----------------------------------------------
   -- Urd Adjectives
   -----------------------------------------------
   
    Adjective = { s: Number => Gender => Case => Degree => Str };    


    mkAdjective : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36:Str) -> Adjective = 
    \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20,y21,y22,y23,y24,y25,y26,y27,y28,y29,y30,y31,y32,y33,y34,y35,y36 -> {
     s = table {
	    Sg => table {
		        Masc => table {
				        Dir => table {
						     Posit  => y1 ;
                             Compar => y2 ;
                             Superl => y3
							 };
						Obl => table {
						     Posit  => y4 ;
                             Compar => y5 ;
                             Superl => y6
							 };
						Voc => table {
						     Posit  => y7 ;
                             Compar => y8 ;
                             Superl => y9
							 }
							};
				Fem => table {
				        Dir => table {
						     Posit  => y10 ;
                             Compar => y11 ;
                             Superl => y12
							 };
						Obl => table {
						     Posit  => y13 ;
                             Compar => y14 ;
                             Superl => y15
							 };
						Voc => table {
						     Posit  => y16 ;
                             Compar => y17 ;
                             Superl => y18
							 }
							}
					};		
			Pl => table {
		        Masc => table {
				        Dir => table {
						     Posit  => y19 ;
                             Compar => y20 ;
                             Superl => y21
							 };
						Obl => table {
						     Posit  => y22 ;
                             Compar => y23 ;
                             Superl => y24
							 };
						Voc => table {
						     Posit  => y25 ;
                             Compar => y26 ;
                             Superl => y27
							 }
							}; 
				Fem => table {
				        Dir => table {
						     Posit  => y28 ;
                             Compar => y29 ;
                             Superl => y30
							 };
						Obl => table {
						     Posit  => y31 ;
                             Compar => y32 ;
                             Superl => y33
							 };
						Voc => table {
						     Posit  => y34 ;
                             Compar => y35 ;
                             Superl => y36
							 }
							}
                        }
                    }
            };					
							 
 
    regAdjective : Str -> Adjective; 
	regAdjective x =  case x of {
	      acch + ("ا"|"اں") => mkAdjective x            ("بہت" ++ x)          ("ساب سے" ++ x)          (acch + "ے") ("بہت" ++ acch + "ے") ("ساب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("ساب سے" ++ acch + "ے")
		                                   (acch + "ی") ("بہت" ++ acch + "ی") ("ساب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("ساب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("ساب سے" ++ acch + "ی")
									       (acch +"ے")  ("بہت" ++ acch + "ے") ("ساب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("ساب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("ساب سے" ++ acch + "ے")
		                                   (acch + "ی") ("بہت" ++ acch + "ی") ("ساب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("ساب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("ساب سے" ++ acch + "ی");
									
          _                 => mkAdjective  x x x x x x x x x
                                            x x x x x x x x x
                                            x x x x x x x x x
                                            x x x x x x x x x									 
                            }; 
					 
		 

  RefPron : Str;
  RefPron = "خود";
  
  ----------------------------------------------------------
  -- Grammar part
  ----------------------------------------------------------
  
  param
    Agr = Ag Gender Number UPerson ;
    NPCase = NPC Case | NPObj | NPErg ;

  oper
    np2pronCase :  (Case => Str) -> NPCase -> Str = \ppf,npc -> case npc of {
       NPC c => ppf ! c;
       NPObj => ppf ! Dir ;
       NPErg => ppf ! Obl ++ "نع"
      } ;
    
	toNP : ( Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
      NPC c => pn !  c ;
      NPObj => pn !  Dir ;
      NPErg => pn !  Obl ++ "نع"
      } ;
	detcn2NP : (Determiner) -> Noun -> NPCase -> Number -> Str = \dt,cn,npc,nn -> case npc of {
       NPC c => dt.s ! Sg ! Masc ++ cn.s ! nn ! Dir ;
       NPObj => dt.s ! Sg ! Masc ++ cn.s ! nn ! Dir ;
       NPErg => dt.s ! Sg ! Masc ++ cn.s ! nn ! Obl ++ "نع"
      } ;  
    det2NP : (Determiner) -> NPCase -> Str = \dt,npc -> case npc of {
       NPC c => dt.s ! Sg ! Masc ;
       NPObj => dt.s ! Sg ! Masc ;
       NPErg => dt.s ! Sg  ! Masc ++ "نع"
      } ;    
	  
------------------------------------------
-- Agreement transformations
-----------------------------------------
    toAgr : Number -> UPerson -> Gender -> Agr = \n,p,g ->       
	   Ag g n p;
      

    fromAgr : Agr -> {n : Number ; p : UPerson ; g : Gender} = \a -> case a of {
      Ag g n p => {n = n ; p = p ; g = g} 
	  } ;
	  
	conjAgr : Agr -> Agr -> Agr = \a0,b0 -> 
      let a = fromAgr a0 ; b = fromAgr b0 
      in
      toAgr
        (conjNumber a.n b.n)
        b.p a.g;	  
	
	giveNumber : Agr -> Number =\a -> case a of {
	   Ag _ n _ => n
	};
	giveGender : Agr -> Gender =\a -> case a of {
	   Ag g _ _ => g
	};
    
    defaultAgr : Agr = agrP3 Masc Sg ;
    agrP3 : Gender -> Number -> Agr = \g,n -> Ag g n Pers3_Distant ;	
    personalAgr : Agr = agrP1 Masc Sg ;
    agrP1 : Gender -> Number -> Agr = \g,n -> Ag g n Pers1 ;
	
 param
      CPolarity = 
       CPos
       | CNeg Bool ;  -- contracted or not

 oper
    contrNeg : Bool -> Polarity -> CPolarity = \b,p -> case p of {
    Pos => CPos ;
    Neg => CNeg b
    } ;

	NP : Type = {s : NPCase => Str ; a : Agr} ;
   
 param
    CTense = CPresent | CPast | CFuture ;
    
  oper 
    copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g -> 
      case <t,n,p,g> of {
        <CPresent,Sg,Pers1,_   > => "ہوں" ;
        <CPresent,Sg,Pers2_Casual,_   > => "ہے" ;
        <CPresent,Sg,Pers2_Familiar,_   > => "ہو" ;
		<CPresent,Sg,Pers2_Respect,_   > => "ہیں" ;
        <CPresent,Sg,Pers3_Near,_   > => "ہے" ;
        <CPresent,Sg,Pers3_Distant,_   > => "ہے" ;
		<CPresent,Pl,Pers1,_   > => "ہیں" ;
        <CPresent,Pl,Pers2_Casual,_   > => "ہو" ;
        <CPresent,Pl,Pers2_Familiar,_   > => "ہو" ;
		<CPresent,Pl,Pers2_Respect,_   > => "ہیں" ;
        <CPresent,Pl,Pers3_Near,_   > => "ہیں" ;
        <CPresent,Pl,Pers3_Distant,_   > => "ہیں" ;
		<CPast,Sg,Pers1,Masc   > => "تھا" ;
		<CPast,Sg,Pers1,Fem   > => "تھی" ;
        <CPast,Sg,Pers2_Casual,Masc   > => "تھا" ;
		<CPast,Sg,Pers2_Casual,Fem   > => "تھی" ;
        <CPast,Sg,Pers2_Familiar,Masc   > => "تھا" ;
		<CPast,Sg,Pers2_Familiar,Fem   > => "تھی" ;
		<CPast,Sg,Pers2_Respect,Masc   > => "تھے" ;
		<CPast,Sg,Pers2_Respect,Fem   > => "تھیں" ;
        <CPast,Sg,Pers3_Near,Masc   > => "تھا" ;
		<CPast,Sg,Pers3_Near,Fem   > => "تھی" ;
        <CPast,Sg,Pers3_Distant,Masc  > => "تھا" ;
		<CPast,Sg,Pers3_Distant,Fem  > => "تھی" ;
		<CPast,Pl,Pers1,Masc   > => "تھے" ;
		<CPast,Pl,Pers1,Fem   > => "تھیں" ;
        <CPast,Pl,Pers2_Casual,Masc   > => "تھے" ;
		<CPast,Pl,Pers2_Casual,Fem   > => "تھیں" ;
        <CPast,Pl,Pers2_Familiar,Masc   > => "تھے" ;
		<CPast,Pl,Pers2_Familiar,Fem   > => "تھیں" ;
		<CPast,Pl,Pers2_Respect,Masc   > => "تھے" ;
		<CPast,Pl,Pers2_Respect,Fem   > => "تھیں" ;
        <CPast,Pl,Pers3_Near,Masc   > => "تھے" ;
		<CPast,Pl,Pers3_Near,Fem   > => "تھیں" ;
		<CPast,Pl,Pers3_Distant,Masc   > => "تھے" ;
		<CPast,Pl,Pers3_Distant,Fem   > => "تھیں" ;
		<CFuture,Sg,Pers1,Masc   > => "گا" ;
		<CFuture,Sg,Pers1,Fem   > => "گی" ;
        <CFuture,Sg,Pers2_Casual,Masc   > => "گا" ;
		<CFuture,Sg,Pers2_Casual,Fem   > => "گi" ;
        <CFuture,Sg,Pers2_Familiar,Masc   > => "گے" ;
		<CFuture,Sg,Pers2_Familiar,Fem   > => "گی" ;
		<CFuture,Sg,Pers2_Respect,Masc   > => "گے" ;
		<CFuture,Sg,Pers2_Respect,Fem   > => "گی" ;
        <CFuture,Sg,Pers3_Near,Masc   > => "گا" ;
		<CFuture,Sg,Pers3_Near,Fem   > => "گی" ;
        <CFuture,Sg,Pers3_Distant,Masc  > => "گا" ;
		<CFuture,Sg,Pers3_Distant,Fem  > => "گی" ;
		<CFuture,Pl,Pers1,Masc   > => "گے" ;
		<CFuture,Pl,Pers1,Fem   > => "گی" ;
        <CFuture,Pl,Pers2_Casual,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Casual,Fem   > => "گی" ;
        <CFuture,Pl,Pers2_Familiar,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Familiar,Fem   > => "گی" ;
		<CFuture,Pl,Pers2_Respect,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Respect,Fem   > => "گی" ;
        <CFuture,Pl,Pers3_Near,Masc   > => "گے" ;
		<CFuture,Pl,Pers3_Near,Fem   > => "گے" ;
		<CFuture,Pl,Pers3_Distant,Masc  > => "گے" ;
		<CFuture,Pl,Pers3_Distant,Fem  > => "گی" 
        
        
        } ;

 param
    VPPTense = 
	  VPPres
	  |VPPast
	  |VPFutr;
      
    VPHTense = 
       VPGenPres  -- impf hum       nahim    "I گo"
     | VPImpPast  -- impf Ta        nahim    "I وعنت"
	 | VPFut      -- fut            na/nahim "I سہالل گo"
     | VPContPres -- stem raha hum  nahim    "I ام گoiنگ"
     | VPContPast -- stem raha Ta   nahim    "I واس گoiنگ"
	 | VPContFut
     | VPPerfPres -- perf hum       na/nahim "I ہاvع گoنع"
     | VPPerfPast -- perf Ta        na/nahim "I ہاد گoنع"          
	 | VPPerfFut
	 | VPPerfPresCont
	 | VPPerfPastCont
	 | VPPerfFutCont
     | VPSubj     -- subj           na       "I مای گo"
     ;

    VPHForm = 
       VPTense VPPTense Agr -- 9 * 12
     | VPReq
     | VPImp
     | VPReqFut
     | VPInf
     | VPStem
     ;

    VType = VIntrans | VTrans | VTransPost ;

  oper
    
	objVType : VType -> NPCase = \vt -> case vt of {
      VTrans => NPObj ;
      _ => NPC Obl
      } ;

    VPH : Type = {
      s    : VPHForm => {fin, inf : Str} ;
      obj  : {s : Str ; a : Agr} ; 
      subj : VType ;
      comp : Agr => Str;
	  inf : Str;
	  ad  : Str;
      embComp : Str ;
      } ;
	
	VPHSlash = VPH ** {c2 : Compl} ;

    Compl : Type = {s : Str ; c : VType} ;

   predV : Verb -> VPH = \verb -> {
      s = \\vh => 
	   case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = verb.s ! VF Imperf p n g } ;
		 VPTense VPPast (Ag g n p) => {fin = [] ; inf =verb.s ! VF Perf p n g} ;
		 VPTense VPFutr (Ag g n p) =>  {fin = copula CFuture n p g ; inf =  verb.s ! VF Subj p n g } ;
		 VPStem => {fin = []  ; inf =  verb.s ! Root};
		 _ => {fin = [] ; inf = verb.s ! Root} 
		 };
	    obj = {s = [] ; a = defaultAgr} ;
		subj = VTrans ;
		inf = verb.s ! Inf;
		ad = [];
        embComp = [];
        comp = \\_ => []
      } ;

    predVc : (Verb ** {c2,c1 : Str}) -> VPHSlash = \verb -> 
    predV verb ** {c2 = {s = verb.c1 ; c = VTrans} } ;

	 
    raha : Gender -> Number -> Str = \g,n -> 
	   (regAdjective "رہا").s ! n ! g ! Dir ! Posit ;

	cka : Gender -> Number -> Str = \g,n -> 
	  (regAdjective "چكا").s ! n ! g ! Dir ! Posit ;
	  
	hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "ہوں";
	 <_,Pl>    => "ہوں";
	 <_,_>		=> "ہو"
	 };
	 
	predAux : Aux -> VPH = \verb -> {
     s = \\vh => 
       let  

		 inf  = verb.inf ;
         part = verb.ppart ;

       in
       case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = part } ;
         VPTense VPPast (Ag g n p) => {fin = copula CPast n p g ; inf = part } ;
         VPTense VPFutr (Ag g n p) => {fin = copula CFuture n p g ; inf = part ++ hw p n  } ;
         VPStem => {fin = []  ; inf = "رہ" };
		 _ => {fin = part ; inf = [] }
		 };
	  obj = {s = [] ; a = defaultAgr} ;
      subj = VIntrans ;
      inf = verb.inf;
	  ad = [];
      embComp = [];
      comp = \\_ => []
      } ;

    Aux = {
      inf,ppart,prpart : Str
    } ;

    auxBe : Aux = {
    inf  = "" ;
    ppart = "" ;
    prpart = ""
    } ;
   	
	Clause : Type = {s : VPHTense => Polarity => Order => Str} ;
	mkClause : NP -> VPH -> Clause = \np,vp -> {
      s = \\vt,b,ord => 
        let 
          subjagr : NPCase * Agr = case vt of {
            VPImpPast => case vp.subj of {
              VTrans     => <NPErg, vp.obj.a> ;
              VTransPost => <NPErg, defaultAgr> ;
              _          => <NPC Dir, np.a>
              } ;
            _ => <NPC Dir, np.a>
            } ;
          subj = subjagr.p1 ;
          agr  = subjagr.p2 ;
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case vt of {

				    VPGenPres  => vp.s !  VPTense VPPres agr ;
					VPImpPast  => vp.s !  VPTense VPPast agr ;
					VPFut      => vp.s !  VPTense VPFutr agr ;
                    VPContPres => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
					VPContPast => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
					VPContFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ raha g n ++ hw p n} ;
					VPPerfPres => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
					VPPerfPast => 
                      {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;					
					VPPerfFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ cka g n  ++ hw p n } ;
					VPPerfPresCont => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
					VPPerfPastCont => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
					VPPerfFutCont => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n  ++ hw p n } ;					
					VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf  ; inf = "ژاید"  }
                   
					};
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "كیا" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "نا" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "نہیں" };
        in
		case vt of {
		VPSubj => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp ;
		_      => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ nahim  ++  vps.inf ++ vps.fin ++ vp.embComp};

  } ;

  mkSClause : Str -> Agr -> VPH -> Clause =
    \subj,agr,vp -> {
      s = \\t,b,ord => 
        let 
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case t of {
                    VPGenPres  => vp.s !  VPTense VPPres agr ;
					VPImpPast  => vp.s !  VPTense VPPast agr ;
					VPFut      => vp.s !  VPTense VPFutr agr ;
					VPContPres => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n  } ;
					VPContPast => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
					VPContFut  => 
					  {fin = copula CFuture n p g  ; inf = (vp.s ! VPStem).inf ++ raha g n ++ hw p n  } ;
					VPPerfPres => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
					VPPerfPast => 
                      {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
					VPPerfFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ cka g n ++ hw p n } ;
					VPPerfPresCont => 
					 {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ; 
					VPPerfPastCont => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ; 
					VPPerfFutCont => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ raha g n ++ hw p n } ;
					VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf ; inf = "ژاید"  }
                    
					};

		  quest =
            case ord of
              { ODir => [];
                OQuest => "كیا" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "نا" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "نہیں" };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ nahim ++  vps.inf ++ vps.fin ++ vp.embComp};
    } ;
    
    insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "وں" ; _ => s ++ "ے"};
     
    insertObj : (Agr => Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp;
     comp = \\a =>    vp.comp ! a  ++ obj1 ! a 
     } ;
     insertVV : Str -> VPH -> VPH = \obj1,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp;
     comp = \\a =>    vp.comp ! a  ++ obj1  
     } ;
     
    insertObj2 : (Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp ++ obj1;
     comp = vp.comp
     
     } ;
	 
	insertObjc : (Agr => Str) -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj obj vp ** {c2 = vp.c2} ;
    insertObjc2 : Str -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj2 obj vp ** {c2 = vp.c2} ;

	infVP : Bool -> VPH -> Agr -> Str = \isAux,vp,a ->
     vp.obj.s ++ vp.inf ++ vp.comp ! a ;
    infVV : Bool -> VPH -> Str = \isAux,vp -> 
      case isAux of {False => vp.inf ; True => (vp.s ! VPImp).fin };

    insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
      obj = {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ++ vps.c2.s ; a = np.a} ;
      subj = vps.c2.c ;
	  inf = vps.inf;
	  ad = vps.ad;
      embComp = vps.embComp;
      comp = vps.comp
      } ;
	  
	insertObjPre : (Agr => Str) -> VPHSlash -> VPH = \obj,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj ;
	 ad = vp.ad ;
     embComp = vp.embComp;
     comp = \\a =>   obj ! a  ++ vp.c2.s ++ vp.comp ! a 
    } ;

    insertAdV : Str -> VPH -> VPH = \ad,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
	 subj = vp.subj;
     ad  = vp.ad ++ ad ;
     embComp = vp.embComp;
     comp = vp.comp
    } ;
	conjThat : Str = "كہ" ;

-- strings collected from syntax files, AR

oper
  sE_Str = "سے" ;
  ka_Str = "كا" ;
  hr_kwy_Str = "ہر كوی" ;
  rakh6na_Str = "راكھنا" ;
  comma_Str = "," ;
  agr_Str = "اگر" ;
  nE_Str = "نے" ;
  jw_Str = "جو" ;
  js_Str = "جس" ;
  jn_Str = "جن" ;
  mt_Str = "مت" ;
  nh_Str = "نہ" ;
  waN_Str = "واں" ;
  awr_Str = "اور" ;
  ky_Str = "كی" ;
  kw_Str = "كو" ;
   
}

