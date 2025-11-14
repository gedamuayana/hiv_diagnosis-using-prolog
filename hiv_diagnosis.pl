% ============================================
% HIV Diagnosis and Advisory System in Prolog
% ============================================

% Risk factors and symptoms associated with HIV
risk_factor(unprotected_sex).
risk_factor(multiple_partners).
risk_factor(shared_needles).
risk_factor(blood_transfusion).
risk_factor(parent_hiv).

symptom(fever).
symptom(fatigue).
symptom(weight_loss).
symptom(night_sweats).
symptom(rash).
symptom(swollen_lymph_nodes).

% Risk level rules
% Low risk: Fewer than 2 risk factors or symptoms
risk_level(low) :-
    findall(X, user_risk(X), Risks),
    findall(Y, user_symptom(Y), Symptoms),
    length(Risks, RiskCount),
    length(Symptoms, SymptomCount),
    Total is RiskCount + SymptomCount,
    Total < 2.

% Moderate risk: 2 to 3 combined factors
risk_level(moderate) :-
    findall(X, user_risk(X), Risks),
    findall(Y, user_symptom(Y), Symptoms),
    length(Risks, RiskCount),
    length(Symptoms, SymptomCount),
    Total is RiskCount + SymptomCount,
    Total >= 2,
    Total =< 3.

% High risk: More than 3 combined factors
risk_level(high) :-
    findall(X, user_risk(X), Risks),
    findall(Y, user_symptom(Y), Symptoms),
    length(Risks, RiskCount),
    length(Symptoms, SymptomCount),
    Total is RiskCount + SymptomCount,
    Total > 3.

% Provide advice based on risk level
advice(low) :-
    write('You are at low risk for HIV. Stay cautious and follow preventive measures.'), nl.
advice(moderate) :-
    write('You are at moderate risk for HIV. It is recommended that you consult a healthcare provider and consider getting tested.'), nl.
advice(high) :-
    write('You are at high risk for HIV. Please seek medical advice immediately and get tested as soon as possible.'), nl.

% ============================================
% Interactive Question and Answer System
% ============================================

:- dynamic(user_risk/1).
:- dynamic(user_symptom/1).

% Ask the user about risk factors
ask_risk_factors :-
    risk_factor(Risk),
    format('Have you experienced ~w? (yes/no): ', [Risk]),
    read(Response),
    handle_response(Response, user_risk(Risk)),
    fail.
ask_risk_factors.

% Ask the user about symptoms
ask_symptoms :-
    symptom(Symptom),
    format('Do you have ~w? (yes/no): ', [Symptom]),
    read(Response),
    handle_response(Response, user_symptom(Symptom)),
    fail.
ask_symptoms.

% Handle user response
handle_response(yes, Fact) :- assertz(Fact).
handle_response(no, _).

% Diagnose HIV risk
diagnose_hiv :-
    ask_risk_factors,
    ask_symptoms,
    risk_level(Level),
    write('Based on your responses, your risk level is: '), write(Level), nl,
    advice(Level).

% ============================================
% Query to Start the System
% ============================================

% Start the HIV diagnosis and advisory system
start_hiv_diagnosis :-
    retractall(user_risk(_)),
    retractall(user_symptom(_)),
    write('Welcome to the HIV Diagnosis and Advisory System.'), nl,
    write('Please answer the following questions accurately.'), nl,
    diagnose_hiv.





