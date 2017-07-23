function [KanalNr]= IDChannel(ID)
 load ID_Zuordnung.mat;
 IDmatrix=ClutterID;
 a=find(IDmatrix==ID);
 KanalNr=a;
end
 

