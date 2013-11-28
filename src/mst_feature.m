function [mst_feature] = mst_feature(locations)

% Generate adjacency matrix from distance graph
adj = gen_adj(locations);

% Kruskal algorithm implementation with path compression
n = size(adj, 1);   % Number of vertices
edge_w  = 0;    % Edges with weights
edge_cnt = 0;
for i = 1:n
    for j = (i+1):n
        edge_cnt = edge_cnt + 1;
        edge_w(edge_cnt, 1) = adj(i, j);
        edge_w(edge_cnt, 2) = i;
        edge_w(edge_cnt, 3) = j;
    end
end

% Sort edges in non-decreasing order of weights
sorted_edge_w = sortrows(edge_w);

% Union-find algorithm with disjoint sets data structure
global parent rank;
parent = 0;
parent(1:n) = 1:n;

rank = 0;
rank(1:n) = 0;

% Visit each edge in the sorted edges array and if two edge vertices are in
% different sets, merge them and add the edges to the minimum spanning tree
% Path compression is also employed.
MSTedge = 0;
MSTedge_cnt = 0;

total = 0;

for i = 1:edge_cnt
    pu = find_root(sorted_edge_w(i, 2));
    pv = find_root(sorted_edge_w(i, 3));
    if(pu ~= pv)
        MSTedge_cnt = MSTedge_cnt + 1;
        MSTedge(MSTedge_cnt, 1) = sorted_edge_w(i, 1);
        MSTedge(MSTedge_cnt, 2) = sorted_edge_w(i, 2);
        MSTedge(MSTedge_cnt, 3) = sorted_edge_w(i, 3);
        total = total + sorted_edge_w(i, 1);
        join(pu, pv);
    end
end

if(edge_cnt == 0)
    mst_feature = total;
else
    mst_feature = total/edge_cnt;
end

end

function [r] = find_root(x)
global parent;
if(x == parent(1, x))
    r = x;
else
    r = find_root(parent(1, x));
end
end


function join(x, y)
global parent rank;
a = find_root(x);
b = find_root(y);
if(a == b) 
    return
end
if(rank(1, a) < rank(1, b))
    parent(1, a) = b;
    rank(1, a) = rank(1, a) + rank(1, b);
else
    parent(1, b) = a;
    if(rank(1, a) == rank(1, b))
        rank(1, b) = rank(1, b) + 1;
    else
        rank(1, b) = rank(1, b) + rank(1, a);
    end
end

end


function [adj_mat] = gen_adj(locations)

num_faces = size(locations, 2);
face_widths = zeros(1, num_faces);
face_heights = zeros(1, num_faces);
face_mp = cell(1, num_faces);

for i = 1:num_faces
    face_widths(1, i) = locations{1, i}(1, 3);
    face_heights(1, i) = locations{1, i}(1, 4);
    face_mp{1, i}(1) = locations{1, i}(1, 1) + locations{1, i}(1, 3);
    face_mp{1, i}(2) = locations{1, i}(1, 2) + locations{1, i}(1, 4);
end

adj_mat = zeros(num_faces, num_faces);
for i = 1:num_faces
    for j = 1:num_faces
        adj_mat(i, j) = sqrt((face_mp{1, i}(1, 1) - face_mp{1, j}(1, 1))^2 + (face_mp{1, i}(1, 2) - face_mp{1, j}(1, 2))^2);
    end
end

end