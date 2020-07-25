codeunit 50101 "JQH Job Queue"
{
    procedure CreateJQEntry(JQType: Integer; NoOfEntries: Integer)
    var
        JQEntry: Record "Job Queue Entry";
        JQEntry2: Record "Job Queue Entry";
        Counter, Counter2 : Integer;
    begin
        for Counter := 1 to NoOfEntries do begin
            JQEntry.Init();
            Clear(JQEntry.ID);
            JQEntry."Object Type to Run" := JQEntry."Object Type to Run"::Codeunit;

            case JQType of
                1:
                    begin
                        JQEntry."Object ID to Run" := Codeunit::"JQH Dummy NOT Conc. Process";
                        JQEntry.Description := 'Dummy NOT Concurrent Process';
                    end;
                2:
                    begin
                        JQEntry."Object ID to Run" := Codeunit::"JQH Dummy Error Process";
                        JQEntry.Description := 'Dummy ERROR Process';
                    end;
            end;

            JQEntry."User Session ID" := SessionId();
            JQEntry."JQH Disable Concurrent Run" := false;
            JQEntry."JQH Disable Concurrency" := true;
            JQEntry."JQH Recurrent On Error" := true;
            Codeunit.Run(Codeunit::"Job Queue - Enqueue", JQEntry);

            if JQType = 1 then
                for Counter2 := 1 to 3 do begin
                    JQEntry2.Init();
                    Clear(JQEntry2.ID);
                    JQEntry2."Object Type to Run" := JQEntry2."Object Type to Run"::Codeunit;
                    JQEntry2."Object ID to Run" := Codeunit::"JQH Dummy Concurrent Process";
                    JQEntry2.Description := 'Dummy Concurrent Process';
                    JQEntry2."User Session ID" := SessionId();
                    JQEntry2."JQH Disable Concurrent Run" := false;
                    JQEntry2."JQH Recurrent On Error" := true;
                    Codeunit.Run(Codeunit::"Job Queue - Enqueue", JQEntry2);
                end;
        end;
    end;
}