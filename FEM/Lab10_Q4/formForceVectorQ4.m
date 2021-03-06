%................................................................

function [force]=...
    formForceVectorQ4(GDof,naturalBCs,surfaceOrientation,...
    elementNodes,nodeCoordinates,thickness)

% computation of force vector 
% for Mindlin plate element

% force : force vector
force=zeros(GDof,1);
coef=[2 0 1 0;0 2 0 1; 1 0 2 0;0 1 0 2];
for e=1:length(surfaceOrientation)
    for l=1:length(naturalBCs)
      numNodePerElement = length(elementNodes(l,:));
      numEDOF = numNodePerElement;
      surfDof=zeros(1,numEDOF);
      Surface=surfaceOrientation(e);
       switch Surface
           case 1
                 surfDof(2*(1:2)-1)=2*elementNodes(naturalBCs(l),1:2)-1;
                 surfDof(2*(1:2))=2*elementNodes(naturalBCs(l),1:2);
                 surfNode=nodeCoordinates(elementNodes(naturalBCs(l),1:2),:);

           case 2
                 surfDof(2*(1:2)-1)=2*elementNodes(naturalBCs(l),2:3)-1;
                 surfDof(2*(1:2))=2*elementNodes(naturalBCs(l),2:3);
                 surfNode=nodeCoordinates(elementNodes(naturalBCs(l),2:3),:);

           case 3
                 surfDof(2*(1:2)-1)=2*elementNodes(naturalBCs(l),3:4)-1;
                 surfDof(2*(1:2))=2*elementNodes(naturalBCs(l),3:4);
                 surfNode=nodeCoordinates(elementNodes(naturalBCs(l),3:4),:);

           case 4
                 surfDof(2*(1:2)-1)=2*elementNodes(naturalBCs(l),1:3:4)-1;
                 surfDof(2*(1:2))=2*elementNodes(naturalBCs(l),1:3:4);
                 surfNode=nodeCoordinates(elementNodes(naturalBCs(l),1:3:4),:);

       end
       Le=sqrt((surfNode(1,1)-surfNode(2,1))^2+(surfNode(1,2)-surfNode(2,2))^2);
       surfTratction=[0 -20 0 -20]';
       force(surfDof)=force(surfDof)+coef*surfTratction/6*Le*thickness;
   end
end
