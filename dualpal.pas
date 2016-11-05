{
ID:kjinxin1
PROG:dualpal
LANG:PASCAL
}
var
  i,j,n,s,b,top,sum:longint;
  ans,ans1:array[0..40] of char;
procedure search(t,b:longint);
var
  i,j:longint;
begin
  while t>0 do
    begin
      inc(sum);
      j:=t mod b;
      case j of
        1:ans[sum]:='1'; 2:ans[sum]:='2'; 3:ans[sum]:='3';
        4:ans[sum]:='4'; 5:ans[sum]:='5'; 6:ans[sum]:='6';
        7:ans[sum]:='7'; 8:ans[sum]:='8'; 9:ans[sum]:='9';
        10:ans[sum]:='A'; 11:ans[sum]:='B'; 12:ans[sum]:='C';
        13:ans[sum]:='D'; 14:ans[sum]:='E'; 15:ans[sum]:='F';
        16:ans[sum]:='G'; 17:ans[sum]:='H'; 18:ans[sum]:='I';
        19:ans[sum]:='J'; 20:ans[sum]:='K'; 0:ans[sum]:='0';
      end;
      t:= t div b;
    end;
end;
function judge(t:longint):boolean;
var
  i:longint;
begin
  for i:= 1 to t shr 1 do
    begin
      if ans[i]<>ans[t-i+1] then
        begin
          judge:=false;
          exit;
        end;
    end;
  judge:=true;
end;

begin
  assign(input,'dualpal.in');
  reset(input);
  assign(output,'dualpal.out');
  rewrite(output);
  readln(n,s);
  top:=1;
  while top<=n do
    begin
      inc(s);
      j:=0;
      for b:= 10 downto 2 do
        begin
          sum:=0;
          search(s,b);
          if judge(sum) then
            begin
              inc(j);
            end;
          if j>=2 then
            begin
              inc(top);
              writeln(s);
              break;
            end;
        end;
    end;
end.
