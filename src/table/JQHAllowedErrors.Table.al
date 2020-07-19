table 50100 "JQH Allowed Errors"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Object Type to Run"; Option)
        {
            Caption = 'Object Type to Run';
            DataClassification = SystemMetadata;
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";

            trigger OnValidate()
            begin
                if "Object Type to Run" <> xRec."Object Type to Run" then
                    Validate("Object ID to Run", 0);
            end;
        }
        field(2; "Object ID to Run"; Integer)
        {
            Caption = 'Object ID to Run';
            DataClassification = SystemMetadata;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type to Run"));

            trigger OnLookup()
            var
                NewObjectID: Integer;
            begin
                if LookupObjectID(NewObjectID) then
                    Validate("Object ID to Run", NewObjectID);
            end;
        }
        field(3; "Line No"; Integer)
        {
            Caption = 'Object ID to Run';
            DataClassification = SystemMetadata;
        }
        field(4; "Error Text"; Text[2048])
        {
            Caption = 'Error Text';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Object Type to Run", "Object ID to Run", "Line No")
        {
            Clustered = true;
        }
    }
    procedure LookupObjectID(var NewObjectID: Integer): Boolean
    var
        AllObjWithCaption: Record AllObjWithCaption;
        Objects: Page Objects;
    begin
        if AllObjWithCaption.Get("Object Type to Run", "Object ID to Run") then;
        AllObjWithCaption.FilterGroup(2);
        AllObjWithCaption.SetRange("Object Type", "Object Type to Run");
        AllObjWithCaption.FilterGroup(0);
        Objects.SetRecord(AllObjWithCaption);
        Objects.SetTableView(AllObjWithCaption);
        Objects.LookupMode := true;
        if Objects.RunModal() = Action::LookupOK then begin
            Objects.GetRecord(AllObjWithCaption);
            NewObjectID := AllObjWithCaption."Object ID";
            exit(true);
        end;
        exit(false);
    end;
}