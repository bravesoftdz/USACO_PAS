{
ID:kjinxin1
PROG:holstein
LANG:PASCAL
}
var
  ans,ans1,hash,data,data1:array[0..25] of longint;
  ciliao:array[0..15,0..25] of longint;
  l,r,mid,i,j,v,g:longint;
  o:boolean;
procedure print;
var
  i,j:longint;
begin
  if l=g then
    begin
      write(g,' ');
      for i:= 1 to g-1 do
        write(i,' ');
      writeln(g);
      exit;
    end;
  write(l,' ');
  for i:= 1 to l-1 do
    begin
      write(ans[i],' ');
    end;
  writeln(ans[l]);
end;
procedure search(sum,top,first:longint);
var
  i,j:longint;
begin
  if o then exit;
  if top>sum then
    begin
      for i:= 1 to v do
        begin
          if data1[i]<data[i] then
              exit;
        end;
      o:=true;
      ans:=ans1;
    end;
  if first>g then exit;
  if g-first<sum-top then exit;
  for i:= first to g do
    begin
      for j:= 1 to v do
        begin
          inc(data1[j],ciliao[i,j]);
        end;
      ans1[top]:=i;
      search(sum,top+1,i+1);
      for j:= 1 to v do
        begin
          dec(data1[j],ciliao[i,j]);
        end;
    end;
end;
begin
  assign(input,'holstein.in');
  reset(input);
  assign(output,'holstein.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),0);
  fillchar(hash,sizeof(hash),0);
  fillchar(data,sizeof(data),0);
  fillchar(ciliao,sizeof(ciliao),0);
  fillchar(data1,sizeof(data1),0);
  fillchar(ans1,sizeof(ans1),0);
  readln(v);
  for i:= 1 to v do
    read(data[i]);
  readln;
  readln(g);
  for i:= 1 to g do
    begin
      for j:= 1 to v do
        begin
          read(ciliao[i,j]);
        end;
      readln;
    end;
  l:=1; r:=g;
  while l<r do
    begin
      o:=false;
      mid:=(l+r) shr 1;
      search(mid,1,1);
      if o then
        begin
          r:=mid;
        end
      else l:=mid+1;
    end;
  print;
  close(input); close(output);
end.