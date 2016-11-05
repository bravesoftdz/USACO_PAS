{
ID:kjinxin1
PROG:maze1
LANG:PASCAL
}
const
  dx:array[1..4] of integer=(-1,0,1,0);
  dy:array[1..4] of integer=(0,1,0,-1);
type
  node=record
    x,y,time:longint;
  end;
  dd=array[0..38000] of node;
var
  w,h,i,j,top,x,y,ans,x1,y1,x2,t,y2:longint;
  g:array[-1..300,-1..100] of char;
  hash:array[0..300,0..100] of boolean;
  time1,time2:array[0..100,0..38] of longint;
  a:dd;
function min(m,n:longint):longint;
begin
  if m<n then exit(m) else exit(n);
end;
procedure search;
var
  l,r,i,j,x,y:longint;
begin
  l:=1; r:=1;
  while l<=r do
    begin
      for i:= 1 to 4 do
        begin
          x:=a[l].x+dx[i];
          y:=a[l].y+dy[i];
          if g[x,y]=' ' then
            begin
              x:=x+dx[i];
              y:=y+dy[i];
              if not hash[x,y] then
                begin
                  inc(r);
                  a[r].x:=x; a[r].y:=y; a[r].time:=a[l].time+1;
                  hash[x,y]:=true;
                end;
            end;
        end;
      inc(l);
    end;
  top:=r;
end;
begin
  assign(input,'maze1.in');
  reset(input);
  assign(output,'maze1.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(hash,sizeof(hash),0);
  fillchar(time1,sizeof(time1),0);
  fillchar(time2,sizeof(time2),0);
  fillchar(a,sizeof(a),0);
  readln(w,h);
  for i:= -1 to 2*h+4 do
    for j:= -1 to 2*w+4 do
      g[i,j]:='@';
  t:=0;
  for i:= 1 to 2*h+1 do
    begin
      for j:= 1 to 2*w+1 do
        begin
          read(g[i,j]);
          if (g[i,j]=' ') then
            begin
              if (i=1) or (j=1) or (i=2*h+1) or (j=2*w+1) then
                begin
                  if t=0 then
                    begin
                      inc(t);
                      x1:=i; y1:=j;
                      g[i,j]:='@';
                    end
                  else
                    begin
                      inc(t);
                      x2:=i; y2:=j;
                      g[i,j]:='@';
                    end;
                end;
            end;
        end;
      readln;
    end;
  for i:= 1 to 4 do
    begin
      x:=x1+dx[i]; y:=y1+dy[i];
      if g[x,y]=' ' then
        break;
    end;
  x:=x; y:=y;
  a[1].x:=x; a[1].y:=y; a[1].time:=1; hash[x,y]:=true;
  search;
  for i:= 1 to top do
    begin
      time1[a[i].x shr 1,a[i].y shr 1]:=a[i].time;
    end;
  fillchar(hash,sizeof(hash),0);
  fillchar(a,sizeof(a),0);
  for i:= 1 to 4 do
    begin
      x:=x2+dx[i]; y:=y2+dy[i];
      if g[x,y]=' ' then
        break;
    end;
  a[1].x:=x; a[1].y:=y; a[1].time:=1; hash[x,y]:=true;
  search;
  for i:= 1 to top do
    begin
      time2[a[i].x shr 1,a[i].y shr 1]:=a[i].time;
    end;
  ans:=0;
  for i:= 1 to h do
    for j:= 1 to w do
      begin
        t:=min(time1[i,j],time2[i,j]);
        if t>ans then ans:=t;
      end;
  writeln(ans);
  close(input);
  close(output);
end.