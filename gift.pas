{ID:kjinxin1
PROG:gift1
LANG:PASCAL
}
type
  node=record
    money,time,get,give:longint;
    nam:string;
  end;
var
  g:array[0..10] of node;
  hash:array[0..10000] of integer;
  n,i,j,t,p,k:longint;
  st:string;
function build(st:string):longint;
var
  i,t:longint;
begin
  t:=0;
  for i:= 1 to length(st) do
    begin
      t:=t+ord(st[i])*i*(971+i);
    end;
  t:=t mod 9917;
  if t=0 then inc(t);
  while hash[t]<>0 do
    begin
      if t>=9917 then t:=t mod 9917;
      inc(t);
    end;
  exit(t);
end;

function search(st:string):longint;
var
  i,t:longint;
begin
  t:=0;
  for i:= 1 to length(st) do
    begin
      t:=t+ord(st[i])*i*(971+i);
    end;
  t:=t mod 9917;
  if t=0 then inc(t);
  while g[hash[t]].nam<>st do
    begin
      if t>=9917 then t:=t mod 9917;
      inc(t);
    end;
  exit(t);
end;
begin
  assign(input,'gift1.in');
  reset(input);
  assign(output,'gift1.out');
  rewrite(output);
  fillchar(hash,sizeof(hash),0);
  readln(n);
  for i:= 1 to n do
    begin
      g[i].get:=0;
      g[i].money:=0;
      g[i].give:=0;
      readln(g[i].nam);
      t:=build(g[i].nam);
      hash[t]:=i;
    end;
  for i:= 1 to n do
    begin
      readln(st);
      t:=hash[search(st)]; k:=0;
      readln(g[t].money,g[t].time);
      if g[t].time<>0 then k:=g[t].money div g[t].time;
      g[t].give:=g[t].time*k;
      for j:= 1 to g[t].time do
        begin
          readln(st);
          p:=hash[search(st)];
          inc(g[p].get,k);
        end;
    end;
  for i:= 1 to n do
    begin
      writeln(g[i].nam,' ',g[i].get-g[i].give);
    end;
  close(input);
  close(output);
end.
