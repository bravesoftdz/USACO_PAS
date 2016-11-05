{
ID:kjinxin1
PROG:checker
LANG:PASCAL
}
var
  i,j,n,sum:longint;
  lie,cha,he:array[-26..26] of integer;
  g:array[0..13] of longint;
procedure search(top:longint);
var
  i,j:longint;
begin
  if top>n then
    begin
      inc(sum);
      if sum<=3 then
        begin
          for i:= 1 to n-1 do
            write(g[i],' ');
          writeln(g[n]);
        end;
    end;
  for i:= 1 to n do
    begin
      if (lie[i]=0) and (cha[i-top]=0) and (he[i+top]=0) then
        begin
          lie[i]:=1; cha[i-top]:=1; he[i+top]:=1;
          g[top]:=i;
          search(top+1);
          lie[i]:=0; cha[i-top]:=0; he[i+top]:=0;
        end;
    end;
end;
begin
  {assign(input,'checker.in');
  reset(input);
  assign(output,'checker.out');
  rewrite(output);  }
  fillchar(lie,sizeof(lie),0);
  fillchar(cha,sizeof(cha),0);
  fillchar(he,sizeof(he),0);
  readln(n);
  sum:=0;
  search(1);
  writeln(sum);
  close(input);
  close(output);
end.
