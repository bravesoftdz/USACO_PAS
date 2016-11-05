{
ID:kjinxin1
PROG:spin
LANG:PASCAL
}
type
  node1=record
    st,fi:longint;
  end;
  node=record
    w,top:longint;
    a:array[1..5] of node1;
  end;
var
  g:array[1..5] of node;
  i,j,k,l:longint;
  t:node;
  o:boolean;
  hash,hash1:array[0..359] of boolean;
begin
  assign(input,'spin.in');
  reset(input);
  assign(output,'spin.out');
  rewrite(output);
  for i:= 1 to 5 do
    begin
      read(g[i].w,g[i].top);
      for j:= 1 to g[i].top do
        begin
          read(g[i].a[j].st,g[i].a[j].fi);
          inc(g[i].a[j].fi,g[i].a[j].st);
          g[i].a[j].st:=g[i].a[j].st mod 360;
          g[i].a[j].fi:=g[i].a[j].fi mod 360;
        end;
      readln;
    end;
  o:=false; k:=0;
  while (k<=20000) and not o do
    begin
      fillchar(hash,sizeof(hash),0);
      for i:= 1 to g[1].top do
        begin
          if g[1].a[i].st<=g[1].a[i].fi then
          for j:= g[1].a[i].st to g[1].a[i].fi do
            hash[j]:=true
          else
            begin
              for j:= g[1].a[i].st to 359 do
                hash[j]:=true;
              for j:= 0 to g[1].a[i].fi do
                hash[j]:=true;
            end;
        end;
      for i:= 2 to 5 do
        begin
          fillchar(hash1,sizeof(hash1),0);
          for j:= 1 to g[i].top do
            begin
              if g[i].a[j].st<=g[i].a[j].fi then
              for l:= g[i].a[j].st to g[i].a[j].fi do
                hash1[l]:=true
              else
                begin
                  for l:= g[i].a[j].st to 359 do
                    hash1[l]:=true;
                  for l:= 0 to g[i].a[j].fi do
                    hash1[l]:=true;
                end;
            end;
          l:=0;
          for j:= 0 to 359 do
            begin
              hash[j]:=hash[j] and hash1[j];
              if hash[j] then l:=1;
            end;
          if l=0 then break;
        end;
      if l=1 then o:=true
      else
        begin
          for i:= 1 to 5 do
            begin
              for j:= 1 to g[i].top do
                begin
                  inc(g[i].a[j].st,g[i].w);
                  inc(g[i].a[j].fi,g[i].w);
                  g[i].a[j].st:=g[i].a[j].st mod 360;
                  g[i].a[j].fi:=g[i].a[j].fi mod 360;
                end;
            end;
        end;
      inc(k);
    end;
  if o then writeln(k-1)
  else writeln('none');
  close(input); close(output);
end.