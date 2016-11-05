{
ID:kjinxin1
PROG:beads
LANG:PASCAL
}
type
  node=record
    data,time:longint;
    ch,ch1:char;
  end;
var
  i,j,n,top,ans:longint;
  g,f:array[0..710] of node;
  ch:char;
begin
  assign(input,'beads.in');
  reset(input);
  assign(output,'beads.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(f,sizeof(f),0);
  readln(n);
  top:=0;
  g[0].ch:='a';
  for i:= 1 to n do
    begin
      read(ch);
      if ch=g[top].ch then
        begin
          inc(g[top].time);
        end
      else
        begin
          inc(top);
          inc(g[top].time);
          g[top].ch:=ch;
        end;
    end;
  for i:= 1 to top do
    begin
      g[i+top]:=g[i];
    end;
  top:=top*2;
  f:=g;
  for i:= 1 to top do
    begin
      if f[i].ch='w' then
        begin
          f[i].ch1:=f[i-1].ch;
          f[i].data:=f[i-1].data+f[i].time;
        end
      else
        if f[i-1].ch='w' then
          begin
            if f[i].ch=f[i-1].ch1 then
              begin
                f[i].data:=f[i-1].data+f[i].time;
              end
            else
              f[i].data:=f[i-1].time+f[i].time;
          end
        else
          if f[i].ch=f[i-1].ch then f[i].data:=f[i].time+f[i-1].data
          else
            begin
              f[i].data:=f[i].time;
            end;
    end;
  f[top+1].ch:='a';
  for i:= top downto 1 do
    begin
      if g[i].ch='w' then
        begin
          g[i].ch1:=g[i+1].ch;
          g[i].data:=g[i+1].data+g[i].time;
        end
      else
        if g[i+1].ch='w' then
          begin
            if g[i].ch=g[i+1].ch1 then
              begin
                g[i].data:=g[i+1].data+g[i].time;
              end
            else
              g[i].data:=g[i+1].time+g[i].time;
          end
        else
          if g[i].ch=g[i+1].ch then g[i].data:=g[i].time+g[i+1].data
          else
            begin
              g[i].data:=g[i].time;
            end;
    end;
  ans:=0;
  for i:= 1 to top do
    begin
      if f[i].data+g[i+1].data>ans then ans:=f[i].data+g[i+1].data;
    end;
  if ans<=n then writeln(ans)
  else writeln(n);
  close(input);
  close(output);
end.