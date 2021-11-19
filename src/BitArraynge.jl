baremodule BitArraynge

	import Pkg: instantiate
	instantiate()
	using BitOperations
	#=           [ stuff that is given more methods  ] [ stuff needed to do so  ]  =#
	import Base: push!, append!, BitMatrix, BitVector, @inline, StepRange, Vector


	_cvt_int(x) = (bv = BitVector((false,)) ; bv.chunks[1] = UInt64(x) ; bv.len = 64 ; bv)
	
	@inline _bitindices(I) = bsizeof(I)-1:-1:0

	@inline bitsof(n::I, b_inds::StepRange) where {I <: Integer} = bget.(n, b_inds)

	@inline bitsof(n::I) where {I <: Integer} = bget.(n, bitindices(I))
	
	
	export push!
	function push!(V::BitVector, n::I, b_inds::StepRange=0:1:0) where I <: Integer
		append!(V, bitsof(n))
	end
	
	
	export append!
	function append!(V::BitVector, Ns::Vector{I}) where I <: Integer
		b_inds = bitindices(I)
		for n in Ns
			push!(V, n, b_inds)
		end
	end
	
	
	export BitMatrix
	function BitMatrix(V::Vector{I}) where {I <: Integer}
		hcat((V .|> bitsof)...)
	end
	
	
	export BitVector
	function BitVector(V::Vector{I}) where {I <: Integer}
		vcat((v .|> bitsof)...)
	end

	@inline BitVector(n::I) where {I <: Integer} = bitsof.(n)
	
end # module
