codeunit 50104 "JQH Dummy Concurrent Process"
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
        Sleep(300);
        ExLog."End DT" := CurrentDateTime();
        ExLog.Insert();
        Commit();
    end;
}