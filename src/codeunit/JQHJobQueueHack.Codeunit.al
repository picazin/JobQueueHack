codeunit 83250 "JQH Job Queue Hack"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Dispatcher", 'OnBeforeRun', '', false, false)]
    local procedure OnBeforeRun(var JobQueueEntry: Record "Job Queue Entry"; var Skip: Boolean);
    var
        JQEntry: Record "Job Queue Entry";
    begin
        if (JobQueueEntry."JQH Disable Concurrency" or JobQueueEntry."JQH Disable Concurrent Run") then begin
            JQEntry.LockTable();
            JQEntry.SetCurrentKey("Object Type to Run", "Object ID to Run", Status, ID);
            if JobQueueEntry."JQH Disable Concurrent Run" then begin
                JQEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run");
                JQEntry.SetRange("Object ID to Run", JobQueueEntry."Object ID to Run");
            end;
            JQEntry.SetRange(Status, JQEntry.Status::"In Process");
            JQEntry.SetFilter(ID, '<>%1', JobQueueEntry.ID);
            Skip := not JQEntry.IsEmpty();
        end else begin
            JQEntry.LockTable();
            JQEntry.SetCurrentKey("Starting Time", "JQH Disable Concurrency");
            JQEntry.SetRange(Status, JobQueueEntry.Status::"In Process");
            JQEntry.SetRange("JQH Disable Concurrency", true);
            Skip := not JQEntry.IsEmpty();
        end;

        if Skip then begin
            Randomize();
            Clear(JobQueueEntry."System Task ID"); // to avoid canceling this task, which has already been executed
            JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime + JobQueueEntry."Rerun Delay (sec.)" + Random(1000);
            JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
            JobQueueEntry.Modify();
            Commit();
            Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);
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