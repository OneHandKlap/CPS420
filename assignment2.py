from Walk import Walk as Walk
from Graph import Graph as Graph
import sys
import random
sys.setrecursionlimit(1500)

if __name__ == "__main__":

    graph = Graph.newRandomSimple(30,5,3)
    print (graph.edges)

    