{
ID:kjinxin1
PROG:hamming
LANG:PASCAL
}
var
  ans:array[0..100] of longint;
  n,b,d,i,j,top:longint;
function try1(t:longint):boolean;
var
  i,pos:longint;
begin
  for i:= 1 to top do
    begin
      pos:=t xor ans[i];
      pos := (pos and $55555555) + ((pos shr 1) and $55555555);
      pos := (pos and $33333333) + ((pos shr 2) and $33333333);
      pos := (pos and $0F0F0F0F) + ((pos shr 4) and $0F0F0F0F);
      pos := (pos and $00FF00FF) + ((pos shr 8) and $00FF00FF);
      pos := (pos and $0000FFFF) + ((pos shr 16) and $0000FFFF);
      if pos<d then exit(false);
    end;
  exit(true);
end;
begin
  assign(input,'hamming.in');
  reset(input);
  assign(output,'hamming.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),0);
  readln(n,b,d);
  top:=1;
  ans[top]:=0;
  for i:= 1 to 1 shl b do
    begin
      if try1(i) then
        begin
          inc(top);
          ans[top]:=i;
        end;
      if top>=n then break;
    end;
  for i:= 1 to top do
    begin
      if (i-1) mod 10=0 then write(ans[i])
      else write(' ',ans[i]);
      if i mod 10=0 then writeln;
    end;
  if top mod 10<>0 then writeln;
  close(input); close(output);
end.