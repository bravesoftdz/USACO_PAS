{
ID:kjinxin1
PROG:palsquare
LANG:PASCAL
}
var
  ans,ans1:array[0..20] of char;
  i,j,b,sum,k:longint;
procedure search(t:longint);
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
  assign(input,'palsquare.in');
  reset(input);
  assign(output,'palsquare.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),0);
  readln(b);
  for i:= 1 to 300 do
    begin
      sum:=0;
      j:=sqr(i);
      search(j);
      if judge(sum) then
        begin
          ans1:=ans; j:=sum;
          sum:=0;
          search(i);
          for k:= sum downto 1 do
            write(ans[k]);
          write(' ');
          for k:= j downto 1 do
            write(ans1[k]);
          writeln;
        end;
    end;
  close(input);
  close(output);
end.