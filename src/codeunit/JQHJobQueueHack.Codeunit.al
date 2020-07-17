codeunit 50100 "JQH Job Queue Hack"
{
    procedure CreateJQEntry(NoOfEntries: Integer)
    var
        JQEntry: Record "Job Queue Entry";
        Counter: Integer;
    begin
        for Counter := 1 to NoOfEntries do begin
            JQEntry.Init();
            Clear(JQEntry.ID);
            JQEntry."Object Type to Run" := JQEntry."Object Type to Run"::Codeunit;
            JQEntry."Object ID to Run" := Codeunit::"JQH Dummy Process";
            JQEntry.Description := 'Dummy Process';
            JQEntry."User Session ID" := SessionId();
            JQEntry."JQH Disable Concurrent Run" := true;
            JQEntry."JQH Recurrent On Error" := true;
            Codeunit.Run(Codeunit::"Job Queue - Enqueue", JQEntry);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Dispatcher", 'OnBeforeRun', '', false, false)]
    local procedure OnBeforeRun(var JobQueueEntry: Record "Job Queue Entry"; var Skip: Boolean);
    var
        JQEntry: Record "Job Queue Entry";
    begin
        if JobQueueEntry."JQH Disable Concurrent Run" then begin
            JQEntry.SetCurrentKey("Object Type to Run", "Object ID to Run", Status);
            JQEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run");
            JQEntry.SetRange("Object ID to Run", JobQueueEntry."Object ID to Run");
            JQEntry.SetRange(Status, JQEntry.Status::"In Process");
            Skip := not JQEntry.IsEmpty();
        end;
    end;


}