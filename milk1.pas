{
ID:kjinxin1
PROG:milk2
LANG:PASCAL
}
type
  node=record
    st,fi:longint;
  end;
var
  i,j,n:longint;
  g:array[0..5000] of node;
  st,fi,cl,wl:longint;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=g[(l1+l2) shr 1].st;
  repeat
    while g[l1].st<x do inc(l1);
    while g[l2].st>x do dec(l2);
    if l1<=l2 then
      begin
        t:=g[l1];
        g[l1]:=g[l2];
        g[l2]:=t;
        inc(l1);
        dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if l2>m then paixu(m,l2);
end;
begin
  assign(input,'milk2.in');
  reset(input);
  assign(output,'milk2.out');
  rewrite(output);
  readln(n);
  for i:= 1 to n do
    begin
      readln(g[i].st,g[i].fi);
    end;
  paixu(1,n);
  wl:=0; cl:=g[1].fi-g[1].st;
  st:=g[1].st; fi:=g[1].fi;
  for i:= 2 to n do
    begin
      if g[i].st<=fi then
        begin
          if g[i].fi>fi then
            begin
              fi:=g[i].fi;
              if fi-st>cl then cl:=fi-st;
            end
        end
      else
        begin
          if g[i].st-fi>wl then wl:=g[i].st-fi;
          st:=g[i].st; fi:=g[i].fi;
        end;
    end;
  writeln(cl,' ',wl);
  close(input);
  close(output);
end.