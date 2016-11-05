{
ID:kjinxin1
PROG:camelot
LANG:PASCAL
}
const
  maxn=100000000;
  dx:array[1..8] of integer=(-2,-2,-1,1,2,2,-1,1);
  dy:array[1..8] of integer=(-1,1,2,2,1,-1,-2,-2);
  ch:array['A'..'Z'] of integer=(1,2,3,4,5,6,7,8,9,
                                 10,11,12,13,14,15,
                                 16,17,18,19,20,21,
                                 22,23,24,25,26);
  dx1:array[1..8] of integer=(-1,-1,-1,0,1,1,1,0);
  dy1:array[1..8] of integer=(-1,0,1,1,1,0,-1,-1);
  dx2:array[1..16] of integer=(-2,-2,-2,-2,-2,-1,0,1,2,2,2,2,2,1,0,-1);
  dy2:array[1..16] of integer=(-2,-1,0,1,2,2,2,2,2,1,0,-1,-2,-2,-2,-2);
type
  node=record
    x,y:longint;
  end;
var
  f:array[0..42,0..40,0..42,0..40] of longint;
  g,a:array[0..1200] of node;
  hash:array[-1..40,-1..40] of boolean;
  kx,ky:longint;
  i,j,r,c,top:longint;
procedure init;
var
  i,j,p,q:longint;
  ch1:char;
begin
  readln(r,c);
  for i:= 1 to r do
    for j:= 1 to c do
      hash[i,j]:=true;
  for i:= 1 to r do
    for j:= 1 to c do
      for p:= 1 to r do
        for q:= 1 to c do
          f[i,j,p,q]:=maxn;
  read(ch1); ky:=ch[ch1];
  readln(kx); top:=0;
  while not eof do
    begin
      while not eoln do
        begin
          read(ch1);
          inc(top);
          g[top].y:=ch[ch1]; read(g[top].x,ch1);
        end;
      readln;
    end;
end;
procedure spfa(x,y:longint);
var
  i,j,l,r,x1,y1:longint;
begin
  f[x,y,x,y]:=0;
  l:=1; r:=1;
  a[l].x:=x; a[l].y:=y;
  while l<=r do
    begin
      for i:= 1 to 8 do
        begin
          x1:=a[l].x+dx[i]; y1:=a[l].y+dy[i];
          if hash[x1,y1] and (f[x,y,x1,y1]>f[x,y,a[l].x,a[l].y]+1) then
            begin
              f[x,y,x1,y1]:=f[x,y,a[l].x,a[l].y]+1;
              inc(r); a[r].x:=x1; a[r].y:=y1;
            end;
        end;
      inc(l);
    end;
end;
procedure main;
var
  ans,i,j,p,l,q,sum,sum1,kx1,ky1:longint;
  o:boolean;
begin
  if top=0 then
    begin
      writeln(0); exit;
    end;
  ans:=maxn;
  for i:= 1 to r do
    for j:= 1 to c do
      begin
        sum:=0; sum1:=0;
        for l:= 1 to top do
          begin
            inc(sum1,f[i,j,g[l].x,g[l].y]);
          end;
        l:=1; sum:=sum1;
        if sum+2*f[g[l].x,g[l].y,kx,ky]<sum-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx,ky]+f[i,j,kx,ky] then
          sum:=sum+2*f[g[l].x,g[l].y,kx,ky]
        else
          sum:=sum-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx,ky]+f[i,j,kx,ky];
        for l:= 1 to top do
          begin
            if sum>sum1+2*f[g[l].x,g[l].y,kx,ky] then
              sum:=sum1+2*f[g[l].x,g[l].y,kx,ky];
            if sum>sum1-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx,ky]+f[i,j,kx,ky] then
              sum:=sum1-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx,ky]+f[i,j,kx,ky];
            for p:= 1 to 8 do
              begin
                kx1:=kx+dx1[p]; ky1:=ky+dy1[p];
                if hash[kx1,ky1] then
                  begin
                    if sum>sum1+2*f[g[l].x,g[l].y,kx1,ky1]+1 then
                      sum:=sum1+2*f[g[l].x,g[l].y,kx1,ky1]+1;
                    if sum>sum1-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx1,ky1]+f[i,j,kx1,ky1]+1 then
                      sum:=sum1-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx1,ky1]+f[i,j,kx1,ky1]+1;
                  end;
              end;
            for p:= 1 to 16 do
              begin
                kx1:=kx+dx2[p]; ky1:=ky+dy2[p];
                if hash[kx1,ky1] then
                  begin
                    if sum>sum1+2*f[g[l].x,g[l].y,kx1,ky1]+2 then
                      sum:=sum1+2*f[g[l].x,g[l].y,kx1,ky1]+2;
                    if sum>sum1-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx1,ky1]+f[i,j,kx1,ky1]+2 then
                      sum:=sum1-f[i,j,g[l].x,g[l].y]+f[g[l].x,g[l].y,kx1,ky1]+f[i,j,kx1,ky1]+2;
                  end;
              end;
          end;
        if sum<ans then ans:=sum;
      end;
   writeln(ans);
end;
begin
  assign(input,'camelot.in'); reset(input);
  assign(output,'camelot.out'); rewrite(output);
  fillchar(f,sizeof(f),0);
  fillchar(g,sizeof(g),0);
  fillchar(a,sizeof(a),0);
  fillchar(hash,sizeof(hash),0);
  init;
  for i:= 1 to r do
    for j:= 1 to c do
      begin
        spfa(i,j);
      end;
  main;
  close(input); close(output);
end.