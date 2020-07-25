codeunit 50103 "JQH Other Dummy Conc. Process"
{
    trigger OnRun()
    var
        ExLog: Record "JQH Execution Log";
    begin
        ExLog.LockTable();
        ExLog.Init();
        ExLog."Object Type to Run" := ExLog."Object Type to Run"::Codeunit;
        ExLog."Object ID to Run" := Codeunit::"JQH Other Dummy Conc. Process";
        ExLog."Start DT" := CurrentDateTime();
        ExLog.Insert(true);
        Commit();
        Sleep(100);
        ExLog."End DT" := CurrentDateTime();
        ExLog.Modify();
        Commit();
    end;
}