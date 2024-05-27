unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  I, X, Y: Integer;
  TmpReg, WindowRegion: HRGN;
  hRect: TRect;
begin
  hRect := GetClientRect;
  X := (Width - hRect.Right) div 2;
  Y := Height - hRect.Bottom - GetSystemMetrics(SM_CYSIZEFRAME);
  WindowRegion := CreateRectRgnIndirect(hRect);
  GetWindowRgn(Handle, WindowRegion);
  try
    for I := 0 to ComponentCount - 1 do
      with TControl(Components[I]) do
      begin
        if Parent = Self then
        begin
          TmpReg := CreateRectRgn(Left + X, Top + Y, Width + Left + X, Height + Top + Y);
          try
            CombineRgn(WindowRegion, TmpReg, WindowRegion, RGN_XOR);
          finally
            DeleteObject(TmpReg);
          end;
        end;
      end;
    TmpReg := CreateRectRgnIndirect(hRect);
    try
      GetWindowRgn(Handle, TmpReg);
      CombineRgn(WindowRegion, TmpReg, WindowRegion, RGN_XOR);
      SetWindowRgn(Handle, WindowRegion, True);
    finally
      DeleteObject(TmpReg);
    end;
  finally
    DeleteObject(WindowRegion);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
CLose;
end;

end.
