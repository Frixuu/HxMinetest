package minetest.pathfinding;

enum abstract PathAlgorithm(String) {
    public var AStar = "A*";
    public var AStarNoPrefetch = "A*_noprefetch";
    public var Dijkstra = "Dijkstra";
}
