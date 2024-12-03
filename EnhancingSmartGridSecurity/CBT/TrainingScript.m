Ts = 0.1;
Tf = 60;
mdl = 'Copy_of_n1_cp_2_a_3_copy_converted';
open_system(mdl)
agentblk = [mdl '/AgentDefender'];
%observationInfo = rlFiniteSetSpec(0.2:1:6);
observationInfo=rlNumericSpec([5 1],'LowerLimit',-inf*ones(5,1),'UpperLimit',-inf*ones(5,1),'LowerLimit',-inf*ones(5,1),'UpperLimit',-inf*ones(5,1),'LowerLimit',-inf*ones(5,1),'UpperLimit',-inf*ones(5,1),'LowerLimit',-inf*ones(5,1),'UpperLimit',-inf*ones(5,1),'LowerLimit',-inf*ones(5,1),'UpperLimit',-inf*ones(5,1));
%observationInfo = rlFiniteSetSpec(0.2:1:300);
numObservations = observationInfo.Dimension();

observationInfo.Name = 'observations';

observationInfo.Description = 'frequency';
%observationInfo.Description1 = 'frequency1';
%actionInfo = rlFiniteSetSpec({[1 0:1:8],[2 0:1:8]});
%actionInfo = rlFiniteSetSpec({[1 0.2],[1 0.4],[1 0.6],[1 0.8],[1 1.2],[1 2.2],[1 3.2],[1 4.2],[2 0.8],[2 1.8],[2 2.8],[2 3.8],[2 4.1]});
%actionInfo = rlFiniteSetSpec([1 1]);
%actionInfo = rlFiniteSetSpec(0:5);
%actionInfo=rlNumericSpec([1 1],'LowerLimit', 1.*ones(1,1),'UpperLimit',10.*ones(1,1));

%actionInfo = rlFiniteSetSpec({[1 0:1],[2 0:1],[3 0:1],[4 0:1]});

%actionInfo = rlFiniteSetSpec({[0 0 0 0], [1 1 1 1]});

actionInfo=rlNumericSpec([4 1],'LowerLimit',0.*ones(4,1),'UpperLimit',1.*ones(4,1),'LowerLimit',0.*ones(4,1),'UpperLimit',1.*ones(4,1),'LowerLimit',0.*ones(4,1),'UpperLimit',1.*ones(4,1),'LowerLimit',0.*ones(4,1),'UpperLimit',1.*ones(4,1));




actionInfo.Name = 'frequency';
numActions = actionInfo.Dimension();

env = rlSimulinkEnv(mdl,agentblk,observationInfo,actionInfo);


