{
ID:kjinxin1
PROG:stall4
LANG:PASCAL
}
var
  visit:array[0..400] of boolean;
  match:array[0..400] of longint;
  form:array[0..200] of longint;
  next:array[0..40000] of longint;
  g:array[0..40000] of longint;
  n,m,ans,top:longint;
procedure init;
var
  i,j,s,t:longint;
begin
  fillchar(visit,sizeof(visit),0);
  fillchar(match,sizeof(match),$ff);
  fillchar(form,sizeof(form),$ff);
  fillchar(next,sizeof(next),$ff);
  fillchar(g,sizeof(g),0);
  readln(n,m); top:=0;
  for i:= 1 to n do
    begin
       read(s);
       for j:= 1 to s do
         begin
           read(t);
           inc(top); g[top]:=t;
           next[top]:=form[i];
           form[i]:=top;
         end;
    end;
end;
function dfs(t:longint):boolean;
var
  i,j,v:longint;
begin
  j:=form[t];
  while j<>-1 do
    begin
      v:=g[j];
      if not visit[v] then
        begin
          visit[v]:=true;
          if (match[v]=-1) or (dfs(match[v])) then
            begin
              match[v]:=t; exit(true);
            end;
        end;
      j:=next[j];
    end;
  exit(false);
end;
procedure main;
var
  i,j:longint;
begin
  for i:= 1 to n do
    begin
      fillchar(visit,sizeof(visit),0);
      if dfs(i) then
        inc(ans);
    end;
end;
procedure print;
begin
  writeln(ans);
end;
begin
  assign(input,'stall4.in'); reset(input);
  assign(output,'stall4.out'); rewrite(output);
  init;
  main;
  print;
  close(input); close(output);
end.
