{
ID:kjinxin1
PROG:sprime
LANG:PASCAL
}
var
  n:longint;
  ans:array[0..100000] of longint;
  g:array[0..10] of integer;
  top1,num,i,j,data:longint;
function judge(t:longint):boolean;
var
  i,j:longint;
  o:boolean;
  st,st1:string;
begin
  st:='';
  for i:= 1 to t do
    begin
      str(g[i],st1);
      st:=st+st1;
    end;
  val(st,data);
  o:=true;
  for i:= 2 to trunc(sqrt(data)) do
    begin
      if data mod i=0 then
        begin
          o:=false;
          break;
        end;
    end;
  judge:=o;
end;
procedure search(top:longint);
var
  i,j:longint;
begin
  if top>n then
    begin
      inc(top1);
      ans[top1]:=data;
      exit;
    end;
  if top=1 then
    begin
      for i:= 2 to 9 do
        begin
          g[top]:=i;
          if judge(top) then search(top+1);
        end;
    end
  else
  for i:= 0 to 9 do
    begin
      g[top]:=i;
      if judge(top) then
      search(top+1);
    end;
end;
procedure print;
var
  i:longint;
begin
  for i:= 1 to top1 do
    writeln(ans[i]);
end;
begin
  assign(input,'sprime.in');
  reset(input);
  assign(output,'sprime.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),0);
  readln(n); top1:=0;
  search(1);
  print;
  close(input);
  close(output);
end.
