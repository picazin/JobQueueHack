codeunit 50101 "JQH Dummy Concurrent Process"
{
    trigger OnRun()
    var
        ExLog: Record "JQH Execution Log";
    begin
        ExLog.LockTable();
        ExLog.Init();
        ExLog."Object Type to Run" := ExLog."Object Type to Run"::Codeunit;
        ExLog."Object ID to Run" := Codeunit::"JQH Dummy Concurrent Process";
        ExLog."Start DT" := CurrentDateTime();
        ExLog.Insert(true);
        Commit();
        Sleep(1000);
        ExLog."End DT" := CurrentDateTime();
        ExLog.Modify();
        Commit();
    end;
}