codeunit 50100 "JQH Job Queue Hack"
{
    procedure CreateJQEntry(JQType: Integer; NoOfEntries: Integer)
    var
        JQEntry: Record "Job Queue Entry";
        Counter: Integer;
    begin
        for Counter := 1 to NoOfEntries do begin
            JQEntry.Init();
            Clear(JQEntry.ID);
            JQEntry."Object Type to Run" := JQEntry."Object Type to Run"::Codeunit;

            case JQType of
                1:
                    JQEntry."Object ID to Run" := Codeunit::"JQH Dummy Concurrent Process";
                2:
                    JQEntry."Object ID to Run" := Codeunit::"JQH Dummy Error Process";
            end;

            JQEntry.Description := 'Dummy Process';
            JQEntry."User Session ID" := SessionId();
            JQEntry."JQH Disable Concurrent Run" := false;
            JQEntry."JQH Recurrent On Error" := false;
            Codeunit.Run(Codeunit::"Job Queue - Enqueue", JQEntry);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Dispatcher", 'OnBeforeRun', '', false, false)]
    local procedure OnBeforeRun(var JobQueueEntry: Record "Job Queue Entry"; var Skip: Boolean);
    var
        JQEntry: Record "Job Queue Entry";
    begin
        if JobQueueEntry."JQH Disable Concurrent Run" then begin
            JQEntry.LockTable();
            JQEntry.SetCurrentKey("Object Type to Run", "Object ID to Run", Status, ID);
            JQEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run");
            JQEntry.SetRange("Object ID to Run", JobQueueEntry."Object ID to Run");
            JQEntry.SetRange(Status, JQEntry.Status::"In Process");
            JQEntry.SetFilter(ID, '<>%1', JobQueueEntry.ID);
            Skip := not JQEntry.IsEmpty();

            if Skip then begin
                Randomize();
                Clear(JQEntry."System Task ID"); // to avoid canceling this task, which has already been executed
                JQEntry."Earliest Start Date/Time" := CurrentDateTime + 2000 + Random(5000);
                JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
                JobQueueEntry.Modify();
                Commit();
                Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterFinalizeRun', '', false, false)]
    local procedure OnAfterFinalizeRun(JobQueueEntry: Record "Job Queue Entry");
    var
        AllowedErr: Record "JQH Allowed Errors";
        MatchFound: Boolean;
    begin
        if (JobQueueEntry.Status = JobQueueEntry.Status::Error) then begin

            if JobQueueEntry."JQH Recurrent On Error" then
                Restart(JobQueueEntry);

            if JobQueueEntry."JQH Rec. On Selected Errors" then begin
                AllowedErr.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run");
                AllowedErr.SetRange("Object ID to Run", JobQueueEntry."Object ID to Run");
                if AllowedErr.FindSet() then
                    repeat
                        if StrPos(JobQueueEntry."Error Message", AllowedErr."Error Text") <> 0 then begin
                            MatchFound := true;
                            Restart(JobQueueEntry);
                        end;
                    until (AllowedErr.Next() = 0) or MatchFound;

            end;
        end;
    end;

    local procedure Restart(var JobQueueEntry: Record "Job Queue Entry")
    begin
        JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
        JobQueueEntry.Modify();
        Commit();
        Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);
    end;
}