package iron-triangle

struct triangle {
	speed bool
	cheap bool
	quality bool
}

func (s *Server) coherence(in string) bool {
	var on int // on bits counter
	for index := range in {
		if in[index] != '0' {
			on++
		}
	}

	return on < 3
}

func (s *Server) minimal(in map[status]bool, mask status, index int) (winner status) {
	winner = status{false, false, false}
	totalSwaps := 2

	for candidate := range in {
		caseSwaps := 0
		for itr, value := range candidate {
			if itr == index {
				// Selected one always changes
				continue
			} else if value != mask[itr] {
				caseSwaps++
			}
		}

		if caseSwaps < totalSwaps {
			// Only one change, in addition to the selected one, can be committed
			// Still, the total of changes must be the minimum.
			winner = candidate
			totalSwaps = caseSwaps
		}
	}

	return winner
}

func (s *Server) backtracking(states *set.Sparse, in string, mask status, index int) map[status]bool {
	candidates := make(map[status]bool)

	if len(in) >= 3 || states.IsEmpty() {
		// Base case: status complete
		result := status{in[0] != '0', in[1] != '0', in[2] != '0'}
		candidates[result] = false
		// Check result
		return candidates
	}

	// Set of element to iterate
	var toIterate set.Sparse
	if len(in) == index {
		// If input length is equals to index, the char to input rigth now it's the forced one
		var forced int
		if !mask[index] {
			forced = 1
		}

		// So, only forced char is up to be iterated
		toIterate.Insert(forced)
	} else {
		// By default all possible cases are here considered
		toIterate.Copy(states)
	}

	// While there are more cases to try
	for toIterate.Len() > 0 {
		opt := toIterate.Min() // All cases are diferent, so there is always a minimum
		toIterate.Remove(opt)  // Remove current case for next iteration

		out := in + strconv.Itoa(opt) // Concat case into variable

		if !s.coherence(out) {
			// If is no coherent in this candidate it must be discarted
			continue
		}

		for key := range s.backtracking(states, out, mask, index) {
			candidates[key] = false
		}
	}

	return candidates
}

func (s *Server) compute(v status, index int) (resp *pb.EchoResponse) {
	log.Printf("Handled request for state %v,%v,%v swapping index %v", v[0], v[1], v[2], index)

	var states set.Sparse
	states.Insert(0)
	states.Insert(1)

	var basecase string = ""
	candidates := s.backtracking(&states, basecase, v, index%3)
	winner := s.minimal(candidates, v, index)
	resp = &pb.EchoResponse{Cheap: winner[0], Quality: winner[1], Speed: winner[2]}

	return resp
}