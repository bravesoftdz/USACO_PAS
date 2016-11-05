{
ID:kjinxin1
PROG:pprime
LANG:PASCAL
}
var
  a,b,i,j,top1:longint;
  ans:array[0..1000000] of longint;
  g:array[0..10] of integer;
  st1,st2:string;
procedure search(sum,top:longint);
var
  i,j,data:longint;
  st,st1:string;
  o:boolean;
begin
  if top>((sum+1) shr 1) then
    begin
      st:='';
      for i:= 1 to sum do
        begin
          str(g[i],st1);
          st:=st+st1;
        end;
      val(st,data);
      if (data<a) or (data>b) then exit;
      o:=true;
      for i:= 2 to trunc(sqrt(data)) do
        begin
          if data mod i=0 then
            begin
              o:=false;
              break;
            end;
        end;
      if o then
        begin
          inc(top1);
          ans[top1]:=data;
        end;
      exit;
    end;
  if top=1 then
    begin
      for i:= 1 to 5 do
        begin
          j:=i*2-1;
          g[top]:=j;
          g[sum-top+1]:=j;
          search(sum,top+1);
        end;
    end
  else
    begin
      for i:= 0 to 9 do
        begin
          g[top]:=i;
          g[sum-top+1]:=i;
          search(sum,top+1);
        end;
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
  assign(input,'pprime.in');
  reset(input);
  assign(output,'pprime.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),0);
  readln(a,b); top1:=0;
  str(a,st1); str(b,st2);
  for i:= length(st1) to length(st2) do
    begin
      search(i,1);
    end;
  print;
  close(input);
  close(output);
end.